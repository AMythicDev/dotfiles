#========================== Variables ========================
# Custom path variable
set -x PATH "$HOME/.local/bin/:$HOME/zig:$PATH"
# Rustup
set -x RUST_SRC_PATH ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
# Set editor to neovim
set -x VISUAL nvim
set -x EDITOR nvim
# Set browser to firefox
set -x BROWSER firefox
set -x MOZ_ENABLE_WAYLAND 1

#=========================== Functions =======================
function vim --description "Replace vim with neovim"
    nvim $argv
end

function reinit --description "Clear screen and reinitialize the shell"
    clear
    fish
end

#=========================== Aliases =======================
alias ga='git add'
alias gp='git push'
alias gc='git commit'
alias gco='git checkout'
alias gl='git log --decorate --oneline --graph'
alias gls='git log'
alias gpl='git pull'
alias gm='git merge'
alias gr='git rebase'
alias gst='git status'
alias ncp='ncmpcpp -q'
alias gsw='git switch'
#alias ls='exa --icons --long --header'
alias ecs='emacsclient -c -n'

if status is-interactive
    set -x GPG_TTY (tty)
    source ("env" starship init fish --print-full-init | psub)
end
