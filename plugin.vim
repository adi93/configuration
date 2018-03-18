" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
	function! DoRemote(arg)
      UpdateRemotePlugins
    endfunction
	" Table mode
	Plug 'dhruvasagar/vim-table-mode'
	let g:table_mode_header_fillchar='='

	" NerdTree
 	Plug 'scrooloose/nerdtree'

	" manage buffers
	Plug 'kien/ctrlp.vim'

	""" Gen stuff
	Plug 'tpope/vim-surround' "quotes and stuff
	Plug 'beloglazov/vim-online-thesaurus' "Thesaurus
	
	Plug 'tpope/vim-dispatch' "Asynch execution
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "Autocomplete
	
	""" C plugins
	Plug 'vim-scripts/c.vim' "IDE
	Plug 'ludovicchabant/vim-gutentags' " Ctags

    call plug#end()
"}}}
" Plugins Configuration {{{
	"NerdTree
	nnoremap <F2> :NERDTreeToggle<CR>
	
	" Deoplete
	let g:deoplete#enable_at_startup = 1

	" Online thesaurus
" vim:foldmethod=marker:foldlevel=0
