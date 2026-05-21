return {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = {
        "mfussenegger/nvim-dap",
    },
    config = function()
        local jdtls = require("jdtls")
        local mason_registry = require("mason-registry")

        local is_mac = vim.fn.has("mac") == 1
        local is_win = vim.fn.has("win32") == 1
        local jdtls_config_dir = is_mac and "config_mac" or is_win and "config_win" or "config_linux"

        -- For multi-module Maven/Gradle projects, walk up to the OUTERMOST contiguous
        -- pom.xml / build.gradle. The nearest one is a module root, which makes jdtls
        -- treat sibling modules as external jars (and `gd` lands in decompiled .class).
        local function find_project_root(bufnr)
            local start = vim.api.nvim_buf_get_name(bufnr)
            if start == "" then start = vim.fn.getcwd() end
            local markers = { "pom.xml", "build.gradle", "build.gradle.kts" }
            local outermost
            for dir in vim.fs.parents(start) do
                local has_marker = false
                for _, m in ipairs(markers) do
                    if vim.fn.filereadable(dir .. "/" .. m) == 1 then
                        has_marker = true
                        break
                    end
                end
                if has_marker then
                    outermost = dir
                elseif outermost then
                    break -- left the contiguous chain
                end
            end
            return outermost or vim.fs.root(bufnr, { ".git" })
        end

        local function start_jdtls()
            local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()

            -- Build debug adapter bundles if installed
            local bundles = {}
            if mason_registry.is_installed("java-debug-adapter") then
                local debug_adapter_path = mason_registry.get_package("java-debug-adapter"):get_install_path()
                vim.list_extend(bundles, vim.split(
                    vim.fn.glob(debug_adapter_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
                    "\n", { trimempty = true }
                ))
            end

            local root_dir = find_project_root(0)
            -- Workspace keyed on root_dir (not cwd) so opening from any subdir reuses the same workspace
            local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ":p:h:t")
            local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

            local java_cmd = vim.env.JDTLS_JAVA_EXECUTABLE or "java"
            local config = {
                cmd = {
                    java_cmd,
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.level=ALL",
                    "-Xmx2g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens", "java.base/java.util=ALL-UNNAMED",
                    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                    "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
                    "-configuration", jdtls_path .. "/" .. jdtls_config_dir,
                    "-data", workspace_dir,
                },
                root_dir = root_dir,
                settings = {
                    java = {
                        -- To pin a specific JDK per project, add a `configuration.runtimes`
                        -- entry here. Otherwise jdtls uses the `java` on PATH / $JAVA_HOME.
                        eclipse = { downloadSources = true },
                        maven = { downloadSources = true },
                        implementationsCodeLens = { enabled = true },
                        referencesCodeLens = { enabled = true },
                        inlayHints = { parameterNames = { enabled = "all" } },
                        signatureHelp = { enabled = true },
                        completion = { favoriteStaticMembers = {
                            "org.junit.Assert.*",
                            "org.junit.jupiter.api.Assertions.*",
                            "org.mockito.Mockito.*",
                        }},
                    },
                },
                init_options = {
                    bundles = bundles,
                },
                on_attach = function(_, bufnr)
                    local dap = require("dap")

                    -- Java-specific refactoring keymaps (buffer-local)
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                    end
                    map("n", "<leader>jo", jdtls.organize_imports, "Organize imports")
                    map("n", "<leader>jv", jdtls.extract_variable, "Extract variable")
                    map("n", "<leader>jc", jdtls.extract_constant, "Extract constant")
                    map("v", "<leader>jm", function() jdtls.extract_method(true) end, "Extract method")

                    if #bundles > 0 then
                        require("jdtls").setup_dap({ hotcodereplace = "auto" })
                        dap.set_exception_breakpoints({ "java.lang.Exception" })
                        -- nvim-jdtls registers its provider under the key "jdtls" and
                        -- auto-generates a "Launch <project>: <main>" entry per main class
                        -- without our vmArgs. Suppress it so only our picker entry shows.
                        if dap.providers and dap.providers.configs then
                            dap.providers.configs["jdtls"] = function() return {} end
                        end
                    end

                    -- macOS GLFW/AWT requires the main thread; harmless elsewhere but only
                    -- inject where it's actually needed.
                    local vm_args = is_mac and "-XstartOnFirstThread" or nil

                    dap.configurations.java = {
                        {
                            type = "java",
                            request = "launch",
                            name = "Run Java (pick main class)",
                            vmArgs = vm_args,
                            mainClass = function()
                                return coroutine.create(function(dap_run_co)
                                    local result = vim.lsp.buf_request_sync(0, "workspace/executeCommand", {
                                        command = "vscode.java.resolveMainClass",
                                    }, 10000)
                                    local items = {}
                                    if result then
                                        for _, res in pairs(result) do
                                            if res.result then
                                                for _, item in ipairs(res.result) do
                                                    table.insert(items, item)
                                                end
                                            end
                                        end
                                    end
                                    if #items == 0 then
                                        vim.notify("No main classes found (is jdtls done indexing?)", vim.log.levels.WARN)
                                        coroutine.resume(dap_run_co, dap.ABORT)
                                        return
                                    end
                                    vim.ui.select(items, {
                                        prompt = "Select main class: ",
                                        format_item = function(item)
                                            return string.format("[%s] %s", item.projectName or "?", item.mainClass)
                                        end,
                                    }, function(choice)
                                        coroutine.resume(dap_run_co, choice and choice.mainClass or dap.ABORT)
                                    end)
                                end)
                            end,
                        },
                    }
                end,
            }

            jdtls.start_or_attach(config)
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = start_jdtls,
        })

        -- Handle the buffer that triggered the plugin load
        if vim.bo.filetype == "java" then
            start_jdtls()
        end
    end,
}
