function modified
	set count (git status -s | grep "M" | wc -l)
	if test $count = 0
		printf ""
	else
		printf " %sM" (set_color green;printf "$count" )
	end
end

function deletion
	set count (git status -s | grep "D" | wc -l)
	if test $count = 0
		printf ""
	else
		printf " %sD" (set_color red;printf "$count" )
	end
end

function addition
	set count (git status -s | grep "??" | wc -l)
	if test $count = 0
		printf ""
	else
		printf " %sA" (set_color brgreen;printf "$count" )
	end
end

function gstatus
	printf "%s%s%s" (addition) (modified) (deletion)
end
