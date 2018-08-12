" Syntax{{{
set modelines=1
set number
set backspace=indent,eol,start
set pastetoggle=<F3>
set scrolloff=10
syntax enable
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

function! DecryptFilePre()
	set viminfo=
	set noswapfile
	set nowritebackup
	set nobackup
	set bin
	set spell
	set scrolloff=16
	let g:deoplete#disable_auto_complete=1
	nnoremap <buffer> <F3> o<ESC>o<ESC>i-<ESC>44.o<C-R>=strftime("%c")<CR><ESC>kyyjpoTITLE:
	inoremap *shrug* ¯\_ツ_/¯
endfunction

function! DecryptFilePost()
	:%!gpg -d 2>/dev/null
	set nobin
endfunction

function! EncryptFilePre()
	set bin
	:%!gpg --symmetric --cipher-algo AES256 2>/dev/null
endfunction

function! EncryptFilePost()
	silent u
	set nobin
endfunction

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
function! Comment() 
	" iterate over lines, if comment, than insert comment
	let commentChar = "/"
	let s=line("'<")
	let e=line("'>")
	let index = s
	while index <= e
		call cursor(index,1)
		:normal ^
		let currentChar = strcharpart(getline('.')[col('.') - 1:], 0, 1)		
		if currentChar == ""
		elseif currentChar == commentChar
			" uncomment
			:.s:^\(\s*\)//:\1:
		else
			"comment
			:.s:^://:
		endif
		let index = index + 1
	endwhile
endfunction

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
 highlight Conceal ctermfg=255 ctermbg=0
"}}}
" Mapleader {{{
nnoremap <SPACE> <Nop>
let mapleader="\<SPACE>"
let maplocalleader="\<SPACE>"
"}}}
" Normal Mode mappings {{{
nnoremap j gj
nnoremap k gk
" Highlight the last inserted text
nnoremap gV `[v`]

nnoremap <C-E> :tabn<CR>
" Switch windows
nnoremap <LEFT> <C-W>h
nnoremap <RIGHT> <C-W>l
nnoremap <UP> <C-W>k
nnoremap <DOWN> <C-W>j

" Cut and paste
vnoremap <C-C> "+y
nnoremap <C-V><C-V> "+p

" json format
nnoremap <F5> :%!python -m json.tool<CR> 
nnoremap <F4> :%!xmllint --format -<CR> 
nnoremap <C-[> <C-t>

nnoremap <leader>n :bNext<CR>
nnoremap <leader>m :bprevious<CR>

" quit window
nnoremap <leader>q :q<CR>

" }}}
" {{{ Terminal Mode
nnoremap <leader>z :new<CR>:terminal<CR>asource $HOME/.bash_profile<CR>PS1="\h:\W \u$ "<CR>clear<CR>
tnoremap jk <C-\><C-n>
tnoremap <C-E> <C-\><C-n>:tabn<CR>
" }}}
" Folding {{{
set foldenable
set foldlevelstart=10
set foldmethod=indent

" }}}
" Insert Mode mappings {{{
inoremap jk <ESC>
inoremap <F2> ------------------------<C-M><C-R>=strftime('%c')<C-M><C-M>------------------------<C-M>

" }}}
" Plugins{{{
source ~/.config/nvim/plugin.vim
" }}}
" Cscope {{{
source ~/.config/nvim/cscope.vim
" }}}
" Unicode aliases {{{
" }}}
" Autocommands {{{
autocmd FileType cpp set keywordprg=:term\ cppman
augroup filetype_go
	au!
	let g:go_term_mode = "10split"
	autocmd FileType go nnoremap <buffer> <F3> :GoRun<CR>
	autocmd FileType go nnoremap <buffer> <localleader>d :GoDef<CR>
	autocmd FileType go nnoremap <buffer> <localleader>b :GoDoc<CR>
	autocmd FileType go nnoremap <buffer> <localleader>o <C-o>
	autocmd FileType go nnoremap <buffer> <localleader>i <C-i>
	autocmd FileType go set foldlevel=2
	autocmd FileType go nnoremap <buffer> <F3> :GoRun<CR>
	autocmd FileType go nnoremap <buffer> <F12> :TagbarToggle<CR>
	autocmd FileType go call neomake#configure#automake('nrwi', 500)
	autocmd FileType go nnoremap GA :GoAlternate<CR>
	autocmd FileType go vnoremap <C-A> <ESC>:call Comment()<CR>'<
	autocmd BufWritePost *.go normal! zR
augroup end
augroup encrypted_dia
	autocmd!
	autocmd FileReadPre,BufReadPre *.dia.gpg call DecryptFilePre()
	autocmd FileReadPost,BufReadPost *.dia.gpg call DecryptFilePost()
	autocmd FileWritePre,BufWritePre *.dia.gpg call EncryptFilePre()
	autocmd FileWritePost,BufWritePost *.dia.gpg call EncryptFilePost()
augroup end
augroup filetype_rust
	au!
	autocmd BufWritePre,FileWritePre *.rs :%!rustfmt
augroup end
augroup filetyp wiki
	au!
	autocmd!
	vmap 4 S$
	let @o='F)2lv$hyi[[#jkA|jkpa]]jkGo=== jkpa ===jko[[#Table of contents:|Back to TOC]]jkojko'
augroup end
augroup wi
augroup filetype_python
	au!
	autocmd FileType python nnoremap <F12> :TagbarToggle<CR>
augroup end
" }}} vim:foldmethod=marker:foldlevel=0

