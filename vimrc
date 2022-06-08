set nocompatible
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

"-------------- Ctrl-Z persistant ------------"
if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "", 0700)
endif
set undodir=~/.vim/undodir
set undofile

"--------------- Les racourcis ---------------"
inoremap <c-w>					<esc>:w!<CR>
inoremap <c-q>					<esc>:q!<CR>
inoremap <c-s>					<esc>:w!<CR>
noremap <c-w>					<esc>:w!<CR>
noremap <c-q>					<esc>:q!<CR>
noremap <c-s>					<esc>:w!<CR>
"map <F5> 						:call CompileRun()<CR>
"imap <F5>				 		<Esc>:call CompileRun()<CR>
"vmap <F5> 						<Esc>:call CompileRun()<CR>
"map <F6>						:call RunVSCode()<CR>
"imap <F6>						<Esc>:call RunVSCode()<CR>
"vmap <F6>						<Esc>:call RunVSCode()<CR>
nmap <F8>						:TagbarToggle<CR>
noremap <S-o>					:Stdheader<CR>
noremap <S-n>					:!(norminette)<CR>
noremap <S-m>					:r $HOME/main.template<CR>
noremap <C-d>					:vs 
noremap <S-d>					:split 
noremap <S-Right>				<C-w><Right>
noremap <S-Left>				<C-w><Left>
noremap <S-Up>					<C-w><Up>
noremap <S-Down>				<C-w><Down>
inoremap <TAB>					<TAB>
noremap <C-k>					:!make ; (make run)<CR>
noremap <C-e>					:!gcc *.c -ggdb ; (time ./a.out)<CR>
imap <C-g>						<esc>:NERDTreeToggle<CR>
map <C-g>						:NERDTreeToggle<CR>
imap <C-c>						<esc>:call CopilotToggle()<CR>i
map <C-c>						:call CopilotToggle()<CR>i
let g:CopilotEnabled			= 1

"--------------- Snippets ---------------------------"
let g:UltiSnipsExpandTrigger	="<F2>"

"--------------- utilitaires basiques ---------------"
syntax 	on
set 	mouse=a
set 	cursorline
set 	nu
set 	tabstop=4
set 	shiftwidth=4
set		tw=80
set 	smartindent
set 	autoindent
set 	shiftround
set 	showmode
set 	backspace=indent,eol,start
set 	pumheight=50
set		whichwrap+=<,>,[,]
set 	encoding=utf-8
au 		BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"---------- Qui utilise la scrollbar -----------"
set 	guioptions-=r
set 	guioptions-=R
set 	guioptions-=l
set 	guioptions-=L

"--- Auto resize/open/close quickfix loclist ---"
au FileType qf call AdjustWindowHeight(3, 10)
"au FileType qf call ToggleLocList()
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

"--------------- jeu de couleur ---------------"
highlight Normal ctermbg=none
highlight NonText ctermbg=none
colorscheme 	PaperColor
set background	=dark
set t_Co		=256
let g:lightline = {
      \ 'colorscheme': 'selenized_black',
      \ }


"-------------- Auto Pairs ---------------------"
let g:AutoPairsFlyMode 			= 0
let g:AutoPairsMapCR 			= 0
let g:AutoPairsWildClosedPair 	= ''
let g:AutoPairsMultilineClose 	= 0
imap <silent><CR>				<CR><Plug>AutoPairsReturn

"--------------- CLANG COMPLETER ---------------"
set noinfercase
set completeopt-=preview
set completeopt+=menuone,noselect
let g:clang_library_path='/sgoinfre/goinfre/Perso/stales/llvm+clang/lib/libclang.so.13'
let g:clang_complete_auto = 1
let g:mucomplete#enable_auto_at_startup = 1

"--------------  Gutentags -------------------"
let g:gutentags_ctags_executable = '~/.local/bin/ctags'
let g:gutentags_ctags_tagfile = '.tags'

"----------------  Coc.nvim  -----------------"
set shortmess+=c
set signcolumn=yes
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"---------------  Syntastic  ---------------"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_c_checkers = ['norminette']
let g:syntastic_aggregate_errors = 1
let g:syntastic_c_norminette_exec = 'norminette'

let g:c_syntax_for_h = 1
let g:syntastic_c_include_dirs = ['include', '../include', '../../include', 'libft', '../libft/include', '../../libft/include']
"let g:syntastic_c_norminette_args = '-R CheckTopCommentHeader'
let g:syntastic_check_on_open = 0 
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

"--------------- PL NERDTREE ---------------"
let sbv_open_nerdtree_to_start=1
let sbv_open_nerdtree_with_new_tab=1
autocmd BufCreate * call s:addingNewTab(sbv_open_nerdtree_with_new_tab)
autocmd VimEnter * call s:actionForOpen(sbv_open_nerdtree_to_start)
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

"--------------- FONCTION ---------------"
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

function! CopilotToggle()
  if g:CopilotEnabled
	let g:CopilotEnabled = 0
	Copilot disable
  else
	let g:CopilotEnabled = 1
	Copilot enable
  endif
endfunction

function! ToggleLocList()
	if exists("g:SyntasticLoclist")
		if !exists("g:qfix_win")
			copen
			let g:qfix_win = bufnr("$")
		endif
	endif
endfunction

function! s:actionForOpen(openNerdTree)
	let filename = expand('%:t')
	if !empty(a:openNerdTree)
		NERDTree
	endif
	if !empty(filename)
		wincmd l
	endif
endfunction

function! s:addingNewTab(openNerdTree)
	let filename = expand('%:t')
	if winnr('$') < 2 && exists('t:NERDTreeBufName') == 0
		if !empty(a:openNerdTree)
			NERDTree
		endif
		if !empty(filename)
			wincmd l
		endif
	endif
endfunction

function! s:CloseIfOnlyNerdTreeLeft()
	if exists("t:NERDTreeBufName")
		if exists("g:qfix_win")
			if bufwinnr(t:NERDTreeBufName) != -1
				if winnr("$") == 2
					q
				endif
			endif
		endif
		if bufwinnr(t:NERDTreeBufName) != -1
			if winnr("$") == 1
				q
			endif
		endif
	endif
endfunction

func! CompileRun()
exec "w"
if &filetype == 'c'
	exec "!gcc % -o %< && time ./%<"
elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %"
elseif &filetype == 'sh'
    exec "!time bash %"
elseif &filetype == 'python'
    exec "!time python3 %"
elseif &filetype == 'html'
    exec "!google-chrome % &"
elseif &filetype == 'go'
    exec "!go build %<"
    exec "!time go run %"
elseif &filetype == 'matlab'
    exec "!time octave %"
elseif &filetype == 'vala'
	exec "!valac %"
elseif &filetype == 'vapi'
	exec "!valac % -o %< && time ./%<"
endif
endfunc

func! RunVSCode()
exec "w"
if !isdirectory(/tmp/vscode)
    call mkdir(/tmp/vscode, "", 0700)
endif
exec "!rm -rf /tmp/vscode/*"
if &filetype == 'c'
	exec "!cp % /tmp/vscode/tmp.c && code /tmp/vscode/tmp.c"
endif
endfunc

