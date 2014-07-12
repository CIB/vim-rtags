function! RtagsFollowSymbolUnderCursor()
	call RtagsFollowSymbol(bufname("%"), line("."), col("."))
endfunction

function! RtagsFollowSymbol(nameOfFile, lineNumber, cursorPosition)
	let find=system("rc -f " . a:nameOfFile . ":" . a:lineNumber . ":" . a:cursorPosition)
	let findList = split(find, ":")

	if len(findList) < 3
		echo "Could not follow symbol"
	else
		let foundFile = findList[0]
		let foundLine = findList[1]
		let foundCursor = findList[2]
		exec "edit" . foundFile
		call setpos(".", [0, foundLine, foundCursor, 0])
	end
endfunction
