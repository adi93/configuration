if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
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
	" Plug 'vim-scripts/c.vim' "IDE
	" Plug 'ludovicchabant/vim-gutentags' " Ctags

	""" vim-go
	Plug 'fatih/vim-go', { 'do' : ':GoInstallBinaries' }  

	""" fuzzy find files
	Plug 'ctrlpvim/ctrlp.vim'

	""" csv files
	Plug 'chrisbra/csv.vim'

	""" Markdown
	Plug 'kurocode25/mdforvim/'

	""" Snippeets
	Plug 'SirVer/ultisnips'
    call plug#end()
"}}}
" Plugins Configuration {{{
	"NerdTree
	nnoremap <F2> :NERDTreeToggle<CR>
	
	" Deoplete
	let g:deoplete#enable_at_startup = 1

	" Use tab in autocomplete
	inoremap <silent><expr> <TAB>
				\ pumvisible() ? "\<C-n>" :
				\ <SID>check_back_space() ? "\<TAB>" :
				\ deoplete#mappings#manual_complete()
	function! s:check_back_space() abort "{{{
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
	endfunction"}}}

	let g:go_disable_autoinstall = 0

	" Highlight
	let g:go_highlight_functions = 1  
	let g:go_highlight_methods = 1  
	let g:go_highlight_structs = 1  
	let g:go_highlight_operators = 1  

	" close preview when leaving insert mode
	autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
	
" vim:foldmethod=marker:foldlevel=0
