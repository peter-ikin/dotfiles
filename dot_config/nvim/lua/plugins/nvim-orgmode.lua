return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  config = function()
    -- Setup orgmode
    require('orgmode.utils.treesitter.install').compilers = { 'clang' }
    require('orgmode').setup({
      org_agenda_files = vim.fn.expand('~/orgfiles') .. '/**/*',
      org_default_notes_file = vim.fn.expand('~/orgfiles/refile.org'),
    })
    vim.lsp.enable('org')
  end,
}
