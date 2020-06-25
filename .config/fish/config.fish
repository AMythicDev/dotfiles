# Initialize vim keybindsing
fish_vi_key_bindings

#========================== Variables ========================
# GPG stuff
set GPG_TTY (tty)
set -x GPG_TTY
# Rustup
set -x RUST_SRC_PATH ~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
# Set editor to neovim
set -x VISUAL nvim
set -x EDITOR nvim
# Add osxcross and cargo to bin, Remove the osxcross and cargo part
set -x PATH $PATH /home/Scripts/osxcross/target/bin /home/arijit/.cargo/bin /home/arijit/bin
# Set browser to firefox
set -x BROWSER firefox
# Add osxcross/target/lib to path, it is on a separate partition. Comment it out for most people
set -x LD_LIBRARY_PATH /home/Scripts/osxcross/target/lib
# I use software rendering for some applications, uncomment if you need
#set -x LIBGL_ALWAYS_SOFTWARE 1

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

function add_config --description "A short command to manage dotfiles"
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
alias gl='git log'
alias gpl='git pull'
alias gm='git merge'
alias gr='git rebase'
alias gst='git status'
alias ncp='ncmpcpp -q'
