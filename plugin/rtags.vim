function rtags#EntryFromLine(line)
	let resultList = split(a:line, ":")
	if len(resultList) < 4
		return {}
	else
		let entry = {}
		let entry.filename = resultList[0]
		let entry.lnum = resultList[1]
		let entry.col = resultList[2]
		let entry.vcol = 0
		let entry.text = join(resultList[3:], ":")
		let entry.type = 'ref'
		return entry
	end
endfunction

function! rtags#FindSymbolUnderCursorReferences()
	call rtags#FindSymbol
endfunction

function! rtags#DisplayResults(resultOutput)
	let resultsList = split(a:resultOutput, "\n")
	let locations = []
	for find in resultsList
		let findEntry = rtags#EntryFromLine(find)
		call add(locations, findEntry)
	endfor
	call setloclist(winnr(), locations)
	lopen
endfunction

function! rtags#FindSymbolReferencesUnderCursor()
	call rtags#FindSymbolReferencesAtPosition(bufname("%"), line("."), col("."))
endfunction

function! rtags#FindSymbolReferencesAtPosition(nameOfFile, lineNumber, cursorPosition)
	let results=system("rc -r " . a:nameOfFile . ":" . a:lineNumber . ":" . a:cursorPosition)
	call rtags#DisplayResults(results)
endfunction

function! rtags#FindSymbol(symbolName)
	let results=system("rc -F " . a:symbolName)
	call rtags#DisplayResults(results)
endfunction

function! rtags#FollowSymbolUnderCursor()
	call rtags#FollowSymbol(bufname("%"), line("."), col("."))
endfunction

function! rtags#FollowSymbol(nameOfFile, lineNumber, cursorPosition)
	let find=system("rc -f " . a:nameOfFile . ":" . a:lineNumber . ":" . a:cursorPosition)
	let findList = rtags#EntryFromLine(find)

	if findList == {}
		echo "Could not follow symbol"
	else
		let foundFile = findList.filename
		let foundLine = findList.lnum
		let foundCursor = findList.col
		exec "edit" . foundFile
		call setpos(".", [0, foundLine, foundCursor, 0])
	end
endfunction
