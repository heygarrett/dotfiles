function git
	set --local index (contains --index -- "--force" $argv)
	if contains push $argv; and test -n "$index"
		while read --function --prompt-str "Did you mean --force-with-lease? [Y/n] " lease; or return 1
			switch $lease
				case y Y ""
					set argv[$index] --force-with-lease
					break
				case n N
					break
			end
		end
	end
	command git $argv
end
