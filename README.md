# 🌍 Cross-Platform Dotfiles

Managed with [Chezmoi](https://chezmoi.io/), designed to work seamlessly across macOS, Linux, and Windows from a single overarching repository.

## 🏗️ Current Architecture

This repository currently serves as a unified, cross-platform skeleton for **Neovim**.

Because system paths diverge radically between Unix (`~/.config/nvim`) and Windows (`~\AppData\Local\nvim`), this repository utilizes the **Bridge Method**:
1. **Single Source of Truth:** The actual configuration logic lives in the Unix-standard `dot_config/nvim` directory.
2. **Windows Bridge:** On Windows, Chezmoi ignores the Unix paths and instead drops a minimal `init.lua` file into the `AppData` directory. This script dynamically points Neovim's runtime path back to the shared Unix directory.
3. **Reproducible Environments:** `lazy-lock.json` is strictly tracked to guarantee that all machines run the exact same plugin commit states, preventing cross-platform crashes.

## 🚀 Installation

### macOS / Linux
```bash
# 1. Install Chezmoi
brew install chezmoi

# 2. Initialize and apply
chezmoi init https://github.com/yourusername/dotfiles.git
chezmoi apply
```

### Windows
```powershell
# 1. Install Chezmoi
winget install twpayne.chezmoi

# 2. Initialize and apply
chezmoi init https://github.com/yourusername/dotfiles.git
chezmoi apply
```

## 🤫 Managing Secrets

** Credentials, API keys, PATs etc. are never committed to this repository.**

This system is designed to use the `.local` convention. To add machine-specific secrets without compromising the repository:
1. Create a local file on the target machine (e.g., `~/.zshrc.local` or `~\.profile.local.ps1`).
2. Store your exports and environment variables there.
3. These file extensions are globally ignored via `.chezmoiignore` and will be rejected if you attempt to add them to version control.

## 📦 Updating Neovim Plugins

To avoid Git merge conflicts on the lockfile, treat your primary machine as the source of truth for plugin updates:
1. Open Neovim on your primary machine and run `:Lazy update`.
2. Commit the modified `lazy-lock.json` to this repository and push.
3. On your secondary machines, run `chezmoi update`. 
4. Open Neovim; it should sync automatically. If it doesn't, run `:Lazy restore`.
