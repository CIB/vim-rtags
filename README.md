This plugin provides a few simple functions for accessing rtags from within vim.

You can find rtags at https://github.com/Andersbakken/rtags

Installation
------------
To use this plugin, it is recommended that you install pathogen, see https://github.com/tpope/vim-pathogen

With pathogen installed, simply clone this repository into your `~/.vim/bundle/` directory.

Usage
-----

Before this plugin can be used, you must have `rdm` running and index the relevant C++ source files with `rtags`. A detailed guide on how to do this can be found in the `README` of the `rtags` github repository.

To ease the use of this plugin, the following keybindings can be added to your ~/.vimrc:
```
nnoremap <F5> :call RtagsFollowSymbolUnderCursor()<CR>
```

