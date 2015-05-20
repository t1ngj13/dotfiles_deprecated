set t_Co=256
set number
set cursorline

" Solarized color theme
" Check http://ethanschoonover.com/solarized/vim-colors-solarized
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

let &colorcolumn=join(range(101, 999), ",")

map <C-k><C-b> :NERDTreeToggle<CR>

" Breaking Habits!!
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Remove tailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
:endfunction

set list listchars=tab:\ \ ,trail:.,extends:>
set clipboard=unnamedplus
map <F2> :call TrimWhiteSpace()<CR>
map! <F2> :call TrimWhiteSpace()<CR>
map  <F3> :set hls!<CR>
imap <F3> <ESC>:set hls!<CR>a
vmap <F3> <ESC>:set hls!<CR>gv

let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 0
" ==================================================================================================
" Google specific settings
"
source /usr/share/vim/google/google.vim

Glug gtimporter
Glug youcompleteme-google

Glug codefmt gofmt_executable=goimports
Glug codefmt-google auto_filetypes+=go

" Syntastic
Glug syntastic-google plugin[autocmds] checkers=`{'proto': ['glint'], 'borg':['borgcfg'], 'java': ['glint']}`
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:go_fmt_command="goimports"
let g:syntastic_go_checkers = ['gofmt', 'golint', 'gotype']

Glug gtimporter
noremap <unique> <leader>j :GtImporter<CR>

Glug corpweb
noremap <unique> <leader>cs :CorpWebCs<Space>
noremap <unique> <leader>cf :CorpWebCsFile<CR>

Glug codefmt-google auto_filetypes+=blazebuild,java
Glug blazedeps auto_filetypes=go,

" =================================================================================================
" Automatic Paste Mode
" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
" =================================================================================================
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
