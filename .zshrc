# ========================== START OF ZINIT INSTALLER ==========================
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
autoload -Uz compinit && compinit
# ========================== END OF ZINIT INSTALLER ============================

# ========================== START OF PLUGINS ==================================
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found
zinit snippet OMZP::bun
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::eza
zinit snippet OMZP::podman
zinit snippet OMZP::rust

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
# ========================== END OF PLUGIN =====================================

# ========================== START OF OPTIONS ==================================
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt extendedglob
unsetopt beep
# ========================== END OF OPTIONS ===================================

# ========================== START OF KEYBINDS =================================
bindkey -e
# Ctrl+Arrow key bindings for jumping words
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
# Alternative sequences that might work in some terminals
bindkey "\eOc" forward-word
bindkey "\eOd" backward-word
#
# Home and End Key Bindings
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
# ========================== EN OF KEYBINDS ====================================

# ========================== START OF COMPLETION SETUP =========================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zinit cdreplay -q
# ========================== END OF COMPLETION SETUP  ==========================

# ================= START OF ADDITIONAL CONFIGURATIONS =========================
alias nv=nvim
alias ls=eza
alias ll=eza -la

source "$HOME/.zshenv"
# ================= END OF ADDITIONAL CONFIGURATIONS ==========================

