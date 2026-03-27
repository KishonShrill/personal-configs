# personal-configs
A collection of configuration files (dotfiles) tailored for various applications and enhancing the Linux terminal environment.

This repository serves as a portable, centralized hub for my development environment. It uses **GNU Stow** to seamlessly automate the deployment of these configurations across different machines using symbolic links.

## 📦 Contents
* **Neovim** (`nvim/`) - Custom editor configuration.
* **Tmux** (`tmux/`) - Terminal multiplexer settings (`.tmux.conf`).
* **Bash** (`bash/`) - Shell environment variables and aliases (`.bashrc`, `.bash_profile`, `.bash_aliases`).
* **Git** (`git/`) - Global Git configurations.
* **Copyparty** (`copyparty/`) - File server configuration.

## 🚀 How It Works
This repository uses a symlink-based approach managed by GNU Stow. Instead of copying files, Stow creates live pointers from your home directory directly into this cloned repository. 

Because of this, any tweaks made to your Neovim, Tmux, or Bash environments are instantly saved into this directory, ready to be committed and pushed. A simple `git pull` on another machine will instantly update your active environment.

## ⚙️ Prerequisites
Before setting up the repository, you need to install GNU Stow on your system. 

**For Fedora:**
```bash
sudo dnf install stow
```

**For CachyOS (Arch-based):**
```bash
sudo pacman -S stow
```

## 🛠️ Installation & Setup
Once Stow is installed, run the commands below to wire up all the symlinks automatically.

1. Clone the repository to your machine:
   ```bash
   git clone git@github.com:KishonShrill/personal-configs.git ~/Desktop/personal-configs
   cd ~/Desktop/personal-configs
   ```
2. Use Stow to create the symlinks. We use the `-t ~` (target) flag to ensure the symlinks are placed directly in your home directory, regardless of where this repository is cloned:
   ```bash
   stow -t ~ nvim tmux bash git copyparty
   ```

*(Note: If you ever change the folder structure or add new files inside the packages, simply run `stow -t ~ -R <package_name>` to restow and update the links.)*

## 🔐 Machine-Specific Git Settings (GPG Keys)
To keep this repository clean and highly portable across devices, machine-specific settings like GPG signing keys are intentionally omitted from tracked files.

The tracked `~/.config/git/config` is configured to automatically include an untracked `~/.gitconfig.local` file. 

**On a new machine, simply add your device-specific keys like this:**
```bash
# Set your signing key locally without dirtying the main repo
git config --file ~/.gitconfig.local user.signingkey <YOUR_KEY_ID>
```
