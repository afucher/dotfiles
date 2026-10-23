
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git sudo colored-man-pages)
source "$ZSH/oh-my-zsh.sh"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# Prompt simples
PROMPT='%n@%m %~ %# '

# Aliases
alias ll='ls -lah'
alias la='ls -A'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Prompt minimalista
PROMPT='%F{cyan}%~%f $(git_prompt_info)
%F{green}❯%f '

ZSH_THEME=""
plugins=(git sudo colored-man-pages)

# Exibe branch Git no prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'

# PATH para binários locais
export PATH="$HOME/.local/bin:$PATH"