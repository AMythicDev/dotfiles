source ~/.config/fish/functions/git_display.fish

function fish_prompt
	echo
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end
    set_color brwhite
    printf '%s' $USER
    set_color FFFFFF
    printf ' at '

    set_color brblue
    echo -n (prompt_hostname)
    set_color FFFFFF
    printf ' in '

    set_color brmagenta
    printf '%s' (prompt_pwd)
    set_color normal

    # Line 2
    echo
	if test -d ".git"
		printf "(git@%s" (set_color brred)(git branch --show-current)(set_color normal)
		printf ") "
	end

    if test $VIRTUAL_ENV
        printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
    end
    printf '↪ '
    set_color normal
end
