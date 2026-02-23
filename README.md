# personal-configs
A collection of configuration files (dotfiles) tailored for various applications and enhancing the Linux terminal environment.

This repository serves as a portable, centralized hub for my development environment. It includes a custom bash script that completely automates the deployment of these configurations across different machines using symbolic links.

## 📦 Contents
* **Neovim** (`nvim/`) - Custom editor configuration.
* **Tmux** (`tmux/`) - Terminal multiplexer settings (`.tmux.conf`).
* **Bash** (`bash/`) - Shell environment variables and aliases (`.bashrc`, `.bash_profile`, `.bash_aliases`).
* **Git** (`git/`) - Global Git configurations.
* **Copyparty** (`copyparty/`) - File server configuration.

## 🚀 How It Works
This repository uses a symlink-based approach. Instead of copying files, the setup script creates live pointers from your home directory directly into this cloned repository. 

Because of this, any tweaks made to your Neovim, Tmux, or Bash environments are instantly saved into this directory, ready to be committed and pushed. A simple `git pull` on another machine will instantly update your active environment.

## 🛠️ Installation & Setup
When setting up a new computer, run the provided bootstrap script once to wire up all the symlinks automatically.

1. Clone the repository to your machine:
   ```bash
   git clone git@github.com:KishonShrill/personal-configs.git ~/Desktop/personal-configs
   cd ~/Desktop/personal-configs
   ```
2. Make the script executable (if it isn't already) and run it:
   ```bash
   chmod +x update_configs.sh
   ./update_configs.sh
   ```

## 🔐 Machine-Specific Git Settings (GPG Keys)
To keep this repository clean and highly portable across devices, machine-specific settings like GPG signing keys are intentionally omitted from tracked files.

The tracked `~/.config/git/config` is configured to automatically include an untracked `~/.gitconfig.local` file. 

**On a new machine, simply add your device-specific keys like this:**
```bash
# Set your signing key locally without dirtying the main repo
git config --file ~/.gitconfig.local user.signingkey <YOUR_KEY_ID>
```
