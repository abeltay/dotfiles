# makes color constants available
autoload -U colors && colors

# ensure dotfiles bin directory is loaded first
export -U PATH=/usr/local/bin:$PATH:$HOME/go/bin

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# Editor
export VISUAL=vim
export EDITOR=$VISUAL
export TERM=screen-256color

set -o emacs

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# History file configuration
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=1000

# History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# Add git completion
autoload -Uz compinit && compinit

# zsh vcs_info to show git info
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr '▲'
zstyle ':vcs_info:*' unstagedstr 'Δ'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats ' %F{cyan}[%b%F{yellow}|%F{red}%a%F{cyan}]%f'
zstyle ':vcs_info:*' formats \
  " %{$fg[cyan]%}[%b]%{$fg[green]%}%c%{$fg[yellow]%}%u%{$fg_bold[red]%}%m%{$reset_color%}"
zstyle ':vcs_info:git*+set-message:*' hooks git-st
zstyle ':vcs_info:*' enable git

function +vi-git-st() {
	local behind ahead
	local -a gitstatus

	# for git prior to 1.7
	# behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
	behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | tr -d ' ')
	(( $behind )) && gitstatus+=( "${behind}↓" )

	# for git prior to 1.7
	# ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
	ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | tr -d ' ')
	(( $ahead )) && gitstatus+=( "${ahead}↑" )

	hook_com[misc]+=${(j:/:)gitstatus}
}

precmd() {
	# As always first run the system so everything is setup correctly.
	vcs_info
	# And then just set PS1, RPS1 and whatever you want to. This $PS1
	# is (as with the other examples above too) just an example of a very
	# basic single-line prompt. See "man zshmisc" for details on how to
	# make this less readable. :-)
	if [[ -n ${vcs_info_msg_0_} ]]; then
		# vcs_info found something, that needs space. So a shorter $PWD
		# makes sense.
		PS1=" %B%1~%b${vcs_info_msg_0_} "
		RPS1=""
	else
		# Oh hey, nothing from vcs_info, so we got more space.
		# Let's print a longer part of $PWD...
		PROMPT=" %B%5~%b "
		RPROMPT=""
	fi
}

# Copied from https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
# The git prompt's git commands are read-only and should not interfere with
# other processes. This environment variable is equivalent to running with `git
# --no-optional-locks`, but falls back gracefully for older versions of git.
# See git(1) for and git-status(1) for a description of that flag.
#
# We wrap in a local function instead of exporting the variable directly in
# order to avoid interfering with manually-run git commands by the user.
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

# Copied from https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# ALIASES
# copied from https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh
# ls, the common ones I use a lot shortened for rapid fire usage
ls --color=auto &> /dev/null && alias ls='ls --color=auto' || # credit to Victor Gavro, setting CLICOLOR environment variable for *BSD and Darwin systems - if it's set ls and possibly other utilities would work colored, but GNU ls (for Linux) ignores it. If "ls --color=auto" will not fail (exit status =0) - we have GNU version of ls and making alias to draw color codes in interactive mode, if it fails - then we don't need alias because of CLICOLOR variable. "&> /dev/null" just don't show stderr and stdout if something fail or if it's ok. Works for my linux and osx. (p.s. bash on osx and freebsd doesn't read .bashrc, so put it in .profile. already fixed it).
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list

# Subset of git plugin aliases (sorted alphabetically) from oh-my-zsh (https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh)
alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'

alias gb='git branch'
alias gbd='git branch -d'
alias gbda='git branch --no-color --merged | command grep -vE "^([+*]|\s*(main|develop)\s*$)" | command xargs git branch -d 2>/dev/null'
alias gbD='git branch -D'
alias gbr='git branch --remote'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcr!='git commit -v --amend --reset-author'
alias gcb='git checkout -b'
alias gclean='git clean -id'
alias gcm='git checkout main'
alias gcd='git checkout develop'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

alias gd='git diff'

alias gf='git fetch'
alias gfa='git fetch --all --prune --jobs=10'

alias gl='git pull'
alias glg='git log --stat'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'

alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpv='git push -v'

alias gr='git remote'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase develop'
alias grbi='git rebase -i'
alias grbm='git rebase main'
alias grbs='git rebase --skip'
alias grh='git reset'
alias grhh='git reset --hard'
alias gru='git reset --'
alias grv='git remote -v'

alias gsb='git status -sb'
alias gsh='git show'
alias gsps='git show --pretty=short --show-signature'
alias gss='git status -s'
alias gst='git status'
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'

alias gup='git pull --rebase'
alias gupv='git pull --rebase -v'

alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
