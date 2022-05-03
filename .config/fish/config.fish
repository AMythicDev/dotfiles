# Initialize vim keybindsing
# fish_vi_key_bindings

#========================== Variables ========================
# GPG stuff
set GPG_TTY (tty)
set -x GPG_TTY
# Rustup
set -x RUST_SRC_PATH ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
# Set editor to neovim
set -x VISUAL nvim
set -x EDITOR nvim
# Set browser to firefox
set -x BROWSER firefox
# Wayland on old PCs
set -x LIBGL_ALWAYS_SOFTWARE 1
set -x WLR_NO_HARDWARE_CURSORS 1
set -x MOZ_ENABLE_WAYLAND 1
set -x PATH $PATH:$HOME/.cargo/bin/:$HOME/bin/:$HOME/.emacs.d/bin/

#=========================== Functions =======================
function vim --description "Replace vim with neovim"
    nvim $argv
end

# No fish vim prompt
function fish_mode_prompt
end

function fcg --description "Open fish configuration files"
    if set -q argv[1]
        nvim $HOME/.config/fish/functions/$argv[1].fish
    else
        nvim $HOME/.config/fish/config.fish
    end
end

function confgit --description "A short command to manage dotfiles"
    git --git-dir=$HOME/dotfiles --work-tree=$HOME $argv
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
alias ls='exa --icons --long --header'
alias emacs='emacsclient -c -n'

#============================ Starship ====================
source ("/usr/bin/starship" init fish --print-full-init | psub)

# =============================================================================
# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions -q __zoxide_cd_internal
    if builtin functions -q cd
        builtin functions -c cd __zoxide_cd_internal
    else
        alias __zoxide_cd_internal='builtin cd'
    end
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-aliases, alias these internal functions as
# desired.
#

# Jump to a directory using only keywords.
function __zoxide_z
    set argc (count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions for `z`.
function __zoxide_z_complete
    set -l tokens (commandline -op)
    set -l curr_tokens (commandline -cop)

    if test (count $tokens) -le 2 -a (count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        __fish_complete_directories "$tokens[2]" ''
    else if test (count $tokens) -eq (count $curr_tokens)
        # If the last argument is empty, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (zoxide query -i -- $query)
        and commandline -p "$tokens[1] "(string escape $result)
        commandline -f repaint
    end
end

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query -i -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Convenient aliases for zoxide. Disable these using --no-aliases.
#

# Remove definitions.
function __zoxide_unset
    set --erase $argv >/dev/null 2>&1
    abbr --erase $argv >/dev/null 2>&1
    builtin functions --erase $argv >/dev/null 2>&1
end

__zoxide_unset z
alias z=__zoxide_z
complete -c z -e
complete -c z -f -a '(__zoxide_z_complete)'

__zoxide_unset zi
alias zi=__zoxide_zi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.config/fish/config.fish):
#
# zoxide init fish | source
# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions -q __zoxide_cd_internal
    if builtin functions -q cd
        builtin functions -c cd __zoxide_cd_internal
    else
        alias __zoxide_cd_internal='builtin cd'
    end
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-aliases, alias these internal functions as
# desired.
#

# Jump to a directory using only keywords.
function __zoxide_z
    set argc (count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions for `z`.
function __zoxide_z_complete
    set -l tokens (commandline -op)
    set -l curr_tokens (commandline -cop)

    if test (count $tokens) -le 2 -a (count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        __fish_complete_directories "$tokens[2]" ''
    else if test (count $tokens) -eq (count $curr_tokens)
        # If the last argument is empty, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (zoxide query -i -- $query)
        and commandline -p "$tokens[1] "(string escape $result)
        commandline -f repaint
    end
end

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query -i -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Convenient aliases for zoxide. Disable these using --no-aliases.
#

# Remove definitions.
function __zoxide_unset
    set --erase $argv >/dev/null 2>&1
    abbr --erase $argv >/dev/null 2>&1
    builtin functions --erase $argv >/dev/null 2>&1
end

__zoxide_unset z
alias z=__zoxide_z
complete -c z -e
complete -c z -f -a '(__zoxide_z_complete)'

__zoxide_unset zi
alias zi=__zoxide_zi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.config/fish/config.fish):
#
# zoxide init fish | source

# ============================== Theme Srttings =================================

set gnome_schema org.gnome.desktop.interface
set -x GTK_THEME 'Adapta-Nokto-Eta'
gsettings set $gnome_schema gtk-theme 'Adapta-Nokto-Eta'
gsettings set $gnome_schema icon-theme 'Tela'
gsettings set $gnome_schema cursor-theme 'DMZ'
