# Lines configured by zsh-newuser-install

export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git
	archlinux
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'

source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
unsetopt BEEP

eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/gruvbox.omp.json)"
eval "$(ssh-agent -s)"
