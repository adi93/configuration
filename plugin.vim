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

	" Gen stuff
	Plug 'tpope/vim-surround'
	Plug 'beloglazov/vim-online-thesaurus' "Thesaurus
	Plug 'szw/vim-dict' " Dictionart
	
	Plug 'tpope/vim-dispatch' "Asynch execution

	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "Autocomplete

	""" C plugins
	" Plug 'vim-scripts/c.vim' "IDE
	" Plug 'ludovicchabant/vim-gutentags' " Ctags

	""" vim-go
	Plug 'fatih/vim-go', { 'do' : ':GoUpdateBinaries' }

	""" fuzzy find files
	Plug 'ctrlpvim/ctrlp.vim'

	""" csv files
	Plug 'chrisbra/csv.vim'

	""" ultisnips
	Plug 'SirVer/ultisnips'

	""" rust
	Plug 'rust-lang/rust.vim'
	Plug 'racer-rust/vim-racer'

	""" For note taking
	Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

	""" For async linting
	Plug 'neomake/neomake'

	""" For Tagbar
	Plug 'majutsushi/tagbar'

	""" Airline
	Plug 'vim-airline/vim-airline'

	""" fugitive, for git
	Plug 'tpope/vim-fugitive'

	Plug 'adi93/go-test'
    call plug#end()
"}}}
" Plugins Configuration {{{
	"NerdTree
	nnoremap <F2> :NERDTreeToggle<CR>

	" Deoplete
	let g:deoplete#enable_at_startup = 1

	" Use tab in autocomplete
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

	""" vimwiki
    let wiki_1 = {}
    let wiki_1.path = '~/Private/notes/'
    let wiki_1.path_html = '~/Private/notes/html/'
    let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
    let wiki_1.index = 'main'
	let wiki_1.template_path = '~/Private/notes/templates/'
    let wiki_1.template_default = 'default'
    let wiki_1.template_ext= '.html'


    let g:vimwiki_list = [wiki_1]
	
	" vim dictionary
	nnoremap <leader>D :execute 'Dict ' . shellescape(expand('<cword>'))<CR>
	if exists("g:ctrlp_user_command")
	  unlet g:ctrlp_user_command
	endif
	let g:ctrlp_max_depth = 40
	let g:ctrlp_max_files=0 
	set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*/target/*,*/test/*
	
" vim:foldmethod=marker:foldlevel=0
