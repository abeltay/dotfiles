# dotfiles
## Install
1. (Optional) Backup your existing `.tmux.conf`, `.vimrc` and `.zshrc` in your home directory
1. Change your shell to zsh `chsh -s /bin/zsh`. (Optional) Reload your terminal
1. Clone and `cd` to this repo. Run `./install.sh`
1. Install [homebrew](https://brew.sh/)
1. `brew install tmux`
1. Set up [vim-plug](https://github.com/junegunn/vim-plug#installation)
1. In `vim`
    - Run `:PlugInstall`
    - Run `:GoInstallBinaries` to install [vim-go](https://github.com/fatih/vim-go)'s binaries

### Mac
The default vim installed does not have clipboard feature installed. If you have brew, `brew install vim --without-perl --without-ruby`, copy with `"*yy`

Alternatively, here are some options,
- Select text with `shift-v` and `Enter` then, `:w !pbcopy`
- Use vim's selection. For example, `:.w !pbcopy` or `:,+1w !pbcopy`

## Git configurations
In `.gitconfig`
```
[core]
	excludesfile = ~/.gitignore-global
[user]
	email = <email>
	name = <name>
[includeIf "gitdir:~/github/"]
	path = .gitconfig-personal
```

In `.gitignore-global`
```
*.swp
```

In `.gitconfig-personal`
```
[user]
	email = <email>
	name = <name>
```
