" Syntax{{{
	set modelines=1
	set relativenumber "This will be folded
	set number
	set backspace=indent,eol,start
	set pastetoggle=<F3>
	set scrolloff=10
	syntax enable
" }}}
" Spaces and tabs {{{
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set linebreak
	set whichwrap=[,]
" }}}
" Highlighting {{{
	colorscheme elflord
	set hlsearch
	set wildmenu
	set showmatch
	highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
	highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
	highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
	highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

	syn match OpenBraces /{{/ conceal
	syn match CloseBraces /}}/ conceal
	set conceallevel=2
	hi MyItalics gui=italic cterm=italic term=italic ctermfg=Blue
	hi SpellBad ctermbg=0 ctermfg=3
	hi MatchParen term=reverse ctermbg=1 guibg=DarkCyan
"}}}
" Mapleader {{{
	let mapleader=",,"
"}}}
" Normal Mode mappings {{{
	nnoremap j gj
	nnoremap k gk
	" Highlight the last inserted text
	nnoremap gV `[v`]

	" Switch windows
	nnoremap <LEFT> <C-W>h
	nnoremap <RIGHT> <C-W>l
	nnoremap <UP> <C-W>k
	nnoremap <DOWN> <C-W>j

	" Cut and paste
	nnoremap <C-C> "+yy
	vnoremap <C-C> "+y
	nnoremap <C-P> "+p

	" json format
	nnoremap <F5> :%!python -m json.tool<CR> 
	nnoremap <F4> :%!xmllint --format -<CR> 
	nnoremap <C-[> <C-t>
	nnoremap <F3> i<CR><ESC>i-<ESC>44.A<CR><C-R>=strftime("%c")<CR><ESC>kyyjpoTITLE:

	" Annoying remaps
	nnoremap Q q
	nnoremap W w

" }}}
" Folding {{{
	set foldenable
	set foldlevelstart=10
	nnoremap <space> za
	set foldmethod=indent

" }}}
" Insert Mode mappings {{{
	inoremap jk <ESC>
	inoremap <F2> ------------------------<C-M><C-R>=strftime('%c')<C-M><C-M>------------------------<C-M>

" }}}
" Functions {{{
	function! StripTrailingWhitespaces()
		" save last search & cursor position
		let _s=@/
		let l = line(".")
		let c = col(".")
		%s/\s\+$//e
		let @/=_s
		call cursor(l, c)
	endfunction
	nnoremap <leader>s :call StripTrailingWhitespaces()<CR>
	function! BufSel(pattern)
		let bufcount = bufnr("$")
		let currbufnr = 1
		let nummatches = 0
		let firstmatchingbufnr = 0
		while currbufnr <= bufcount
			if(bufexists(currbufnr))
				let currbufname = bufname(currbufnr)
				if(match(currbufname, a:pattern) > -1)
					echo currbufnr . ": ". bufname(currbufnr)
					let nummatches += 1
					let firstmatchingbufnr = currbufnr
				endif
			endif
			let currbufnr = currbufnr + 1
		endwhile
		if(nummatches == 1)
			execute ":buffer ". firstmatchingbufnr
		elseif(nummatches > 1)
			let desiredbufnr = input("Enter buffer number: ")
			if(strlen(desiredbufnr) != 0)
				execute ":buffer ". desiredbufnr
			endif
		else
			echo "No matching buffers"
		endif
	endfunction
	"Bind the BufSel() function to a user-command 
	command! -nargs=1 Bs :call BufSel("<args>")
	" }}}
" Plugins{{{
	source ~/.config/nvim/plugin.vim
 " }}}
" Cscope {{{
	source ~/.config/nvim/cscope.vim
	" }}}
" Unicode aliases {{{
	inoremap :( <C-v>u2639 
	" bullet
	inoremap bg <C-v>u2022
	" arrow ->
	inoremap raw <C-V>u2192
	" smiley 
	inoremap :( <C-v>u2639 
	" }}}
" Autocommands {{{
	autocmd FileType cpp set keywordprg=:term\ cppman
	autocmd FileType go nnoremap <buffer> <C-b> :GoDef<CR>
	autocmd FileType go nnoremap <buffer> <F3> :GoDoc<CR>
" }}} vim:foldmethod=marker:foldlevel=0
