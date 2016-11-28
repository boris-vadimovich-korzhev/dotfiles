"                                        ██    ██ ██ ██████████  ██████  █████ 
"                                       ░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
"                                       ░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░ 
"                                        ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
"                                         ░░██   ░██ ███ ░██ ░██ ███   ░░█████ 
"                                          ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░  
"       
"
""" options
colorscheme onedark
execute pathogen#infect()
filetype plugin on
filetype off                   
filetype plugin indent on      

set wrap
set nu
set rnu
set incsearch
set noshowmode
set hlsearch
set cursorline
set ttyfast
set ruler
set virtualedit=onemore
set history=500
set wildmenu
set scrolloff=20
set sidescrolloff=20
set ignorecase
set smartcase
set showbreak=>>>
set shortmess=I
set showtabline=2
set magic
set nobackup
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nowb
set noswapfile
set autoread
set completeopt=menu
set confirm
set cuc
set wildmenu
set wildmode=list:longest,full
set backspace=indent,eol,start
set colorcolumn=81
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
set viminfo=h,'500,<1000,s1000,/1000,:1000
set cmdwinheight=25
set cpoptions+=n
set wildignore+=*/home/Data/*,
set foldmethod=manual
set noshowmode
set term=rxvt-unicode-256color
set clipboard+=unnamed
set mouse=a
set ttymouse=xterm2
set fillchars+=vert:█
set backspace=indent,eol,start
set showcmd
set showmatch
set encoding=utf8


""" syntax
syntax enable
autocmd BufRead,BufNewFile *.conf setf dosini
autocmd BufRead,BufNewFile config setf dosini
autocmd BufRead,BufNewFile *.txt setf dosbatch
autocmd FileType text setlocal textwidth=78


""" cmd
autocmd BufWinLeave {*}.{*} mkview
autocmd BufWinEnter {*}.{*} silent loadview 
command! W sudo w ! tee %
command! White %s/^\s*//g


""" maps
nnoremap ; :
nnoremap : ;
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>vi :tabnew $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" quick pairs
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>[ []<ESC>i
imap <leader>{ {}<ESC>i
imap <leader>< <><ESC>i
" ctrl + arrow keys
if &term =~ '^screen'
execute "set <xUp>=\e[1;*A"
execute "set <xDown>=\e[1;*B"
execute "set <xRight>=\e[1;*C"
execute "set <xLeft>=\e[1;*D"
endif
" vis mode search
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>
" clear search
nnoremap <silent> <C-l> :nohl<CR><C-l>


""" functions
" add mode to statusline
function! Mode()
redraw
let l:mode = mode()
if     mode ==# "n" | return "Normal"
elseif mode ==# "i" | return "Insert"
elseif mode ==# "R" | return "Replace"
elseif mode ==# "v" | return "Visual"
elseif mode ==# "V" | return "V-Line"
else                | return "V-Block"
endif
endfunc    
" :H opens full screen help
function! s:help(subject)
let buftype = &buftype
let &buftype = 'help'
let v:errmsg = ''
let cmd = "help " . a:subject
silent! execute  cmd
if v:errmsg != ''
let &buftype = buftype
return cmd
else
call setbufvar('#', '&buftype', buftype)
endif
endfunction
command! -nargs=? -bar -complete=help H execute <SID>help(<q-args>)
" foldtext from the wikia
set foldtext=MyFoldText()
function! MyFoldText()
let line = getline(v:foldstart)
if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
let linenum = v:foldstart + 1
while linenum < v:foldend
let line = getline( linenum )
let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
if comment_content != ''
break
endif
let linenum = linenum + 1
endwhile
let sub = initial . ' ' . comment_content
else
let sub = line
let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
if startbrace == '{'
let line = getline(v:foldend)
let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
if endbrace == '}'
let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
endif
endif
endif
let n = v:foldend - v:foldstart + 1
let info = " " . n . " lines"
let sub = sub . "                                                                                                                                                                                                                 "
let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
let fold_w = getwinvar( 0, '&foldcolumn' )
let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
return sub . info
endfunction


""" pluginis
" tabulous
let tabulousCloseStr = ' '
" ctrlp
"let g:ctrlp_max_height = 35
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_show_hidden = 1
let g:ctrlp_lazy_update = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:25,results:100'
let g:ctrlp_by_filename = 1
let g:ctrlp_max_height = 35
" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" $\LaTeX$
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
" gundo
nnoremap <F5> :GundoToggle<CR>
let g:gundo_width = 30
let g:gundo_preview_height = 30
let g:gundo_preview_bottom = 0
" NERDTree
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=0

""" color
hi Normal ctermbg=none
hi VertSplit ctermbg=none
hi VertSplit ctermfg=Black
hi Border cterm=none ctermfg=black ctermbg=none
hi CmdLine cterm=bold ctermfg=88 ctermbg=234
hi LineNr cterm=bold ctermfg=38 ctermbg=none 
hi Comment cterm=italic ctermfg=white ctermbg=none
hi Directory cterm=bold ctermfg=122 ctermbg=none
hi Identifier cterm=bold cterm=None ctermfg=80 ctermbg=none
hi PreProc cterm=bold  ctermfg=LightBlue ctermbg=none
hi CursorLine ctermbg=234 cterm=none
hi cursorcolumn ctermbg=234 
hi CursorLineNr ctermfg=88 cterm=bold ctermbg=none
hi colorcolumn ctermbg=234
hi ErrorMsg cterm=none ctermfg=white ctermbg=52
hi NonText cterm=bold ctermfg=white ctermbg=none
hi Question cterm=bold ctermfg=69 ctermbg=none
hi Pmenu cterm=none ctermbg=DarkGrey ctermfg=White
hi User1 cterm=bold ctermbg=none ctermfg=38 
hi User2 cterm=bold ctermbg=none ctermfg=7  
hi User3 cterm=bold ctermbg=none ctermfg=63
hi User4 cterm=bold ctermbg=none ctermfg=43
hi User5 cterm=bold ctermbg=none ctermfg=11
hi User6 cterm=bold ctermbg=none ctermfg=27
hi User7 cterm=bold ctermbg=none ctermfg=147
hi User8 cterm=bold ctermbg=none ctermfg=73
hi User9 cterm=bold ctermbg=none ctermfg=69
hi TabLineFill cterm=none ctermfg=none ctermbg=none
hi TabLine cterm=bold ctermfg=white ctermbg=none
hi TabLineSel  cterm=bold ctermfg=38 CTERMBG=none
hi visual cterm=bold ctermfg=160 ctermbg=7
hi Pmenu ctermbg=LightBlue ctermfg=black
hi Pmenusel ctermbg=160 ctermfg=white


""" statusline 
" %< truncation point
" %n buffer number
" %f relative path to file
" %m modified flag [+] (modified), [-] (unmodifiable) or nothing
" %r readonly flag [RO]
" %y filetype [ruby]
" %= split point for left and right justification
" %-35. width specification
" %l current line number
" %L number of lines in buffer
" %c current column number
" %V current virtual column number (-n), if different from %c
" %P percentage through buffer
" %) end of width specification

set laststatus=2
set statusline=
set statusline+=%2*\%{Mode()}
set statusline+=%1*\  
set statusline+=%5*\ \%n\  
set statusline+=%1*\ \%t
set statusline+=%9*\ \%R\ \%h\ \%w
set statusline+=%7*\%{&ff}
set statusline+=%8*\ \ \%Y
set statusline+=%3*\ \ \%{''.(&fenc!=''?&fenc:&enc).''}
set statusline+=%5*\ \ \%M
set statusline+=%4*\%=\%o\ \%c\ \%O\ \%b\ \%B
set statusline+=%6*\ \ \Line\ \%03l\ of\ %03L
set statusline+=%7*\ \ \Col\ \%03v
set statusline+=%9*\ \ \%p%% 



