" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'wincent/command-t' " does fuzzy file matching 
Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-surround'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-eunuch'
Plugin 'scrooloose/nerdtree'
Plugin 'dracula/vim'
Plugin 'junegunn/fzf'
Plugin 'jonstoler/werewolf.vim'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'rhysd/vim-grammarous'
Plugin 'vim-syntastic/syntastic'
Plugin 'simnalamburt/vim-mundo'
Plugin 'morhetz/gruvbox' "Color scheme 1
Plugin 'joshdick/onedark.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-unimpaired'
"Plugin 'taketwo/vim-ros'
Plugin 'pseewald/vim-anyfold'
Plugin 'inkarkat/vim-ingo-library'
Plugin 'inkarkat/vim-spellcheck'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'bling/vim-bufferline'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'sickill/vim-pasta'
Plugin 'gotcha/vimpdb'
Plugin 'gregsexton/gitv'
Plugin 'kshenoy/vim-signature' "Vim marks
Plugin 'easymotion/vim-easymotion' " Movement using leader + <key>
Plugin 'mattn/calendar-vim' " Calander for Vim wiki 
Plugin 'vimwiki/vimwiki.git' " VimWiki 
Plugin 'tpope/vim-repeat'
Plugin 'jiangmiao/auto-pairs'
Plugin 'sainnhe/edge'
Plugin 'ryanoasis/vim-devicons'
"Plugin 'vim-vdebug/vdebug'
Plugin 'christoomey/vim-tmux-navigator'
filetype plugin indent on    " required

" New leader
let mapleader="\<SPACE>"
" Reopen at same place {
    if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
    endif
" }
" Tab {
    set tabstop=4        " tab width is 4 spaces
    set shiftwidth=4     " indent also with 4 spaces
    set expandtab        " replaces tab with spaces
" }
" Visual mode
    nnoremap <leader><leader> V
" }
" Splits {
    nnoremap <leader>- :sp<CR>
    nnoremap <leader>\ :vsp<CR>
    set splitbelow
    set splitright
" }
" redefining motion between tabs/windows{
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>
    nnoremap <leader>w <C-W><C-W>
"}
" remap the arrow keys{
    noremap <Up> <NOP>
    noremap <Down> <NOP>
    noremap <Left> <NOP>
    noremap <Right> <NOP>
" }
" tab switching {
    noremap <S-l> gt
    noremap <S-h> gT
    nnoremap <C-W>M <C-W>\|<C-W>_
    nnoremap <C-W>m <C-W>=
" }
" qq to record, q to stop, Q to use 
" learn dynamic macros{
    nnoremap Q @q
    vnoremap Q :norm @q<cr>
"}
" line numbers are for plebs {
    set number relativenumber
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
        autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    augroup END
    nmap <leader>n :set relativenumber!<CR>
"}
" set stuff{
    set nu
    nmap 0 ^
    " Ignore case when searching
    set ignorecase
    " When searching try to be smart about cases
    set smartcase
    set hlsearch
    " Makes search act like search in modern browsers
    set incsearch
    " esc clears highlight
    nnoremap <esc><esc> :noh<return><esc>
    set ttimeoutlen=50 " sets a time out to help speed it up
    set backspace=indent,eol,start
"}
" Quit current file {
    noremap <leader>Q :q!<cr>
    noremap <leader>q :q<cr>
" }
" Save with CTRL-S both in insert and command mode{
    map <C-s> :w<CR>
    imap <C-s> <Esc>:w<CR>
    imap jj <Esc>
"}
" lightline {
    set laststatus=2
    let g:lightline = { 'colorscheme':'edge',
                \     'active': {
                \         'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'filename', 'modified']],
                \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
                \     },'component_function':{
                \	'gitbranch':'fugitive#head'},
                \}
    "  }
" Nerdtree {
    map <leader>f :NERDTreeToggle<CR>
    let NERDTreeShowHidden=1
" }
" No annoying sound on errors {
    set noerrorbells
    set novisualbell
    set t_vb=
    set tm=500
"}
" Marks and Jumps {
    set viminfo='100,f1
    let g:SignatureMarkTextHLDynamic = 1
    "onoremap ' `
    "onoremap ` '
    "nnoremap ' `
    "nnoremap ` '
    "vnoremap ' `
    "vnoremap ` '
" }
" Indentation {
    set ai "Auto indent
    set si "Smart indent
    set wrap "Wrap lines
" }
" Color settings{
    syntax on
    set t_Co=256
    let g:edge_style='proton'
    let g:edge_enable_italic=1
    let g:edge_current_word='bold'
    colorscheme dracula
    let g:edge_disable_italic_comment = 1
    set background=dark
    "let g:gruvbox_italic=1
    "let g:solarized_termcolors=256
"}
" Syntastic {
    let g:syntastic_cpp_checkers = ['clang_check', 'gcc']
    let g:syntastic_cpp_compiler = 'clang++'
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
" }
" YCM {
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_semantic_triggers = { 'roslaunch' : ['="', '$(', '/'],    'rosmsg,rossrv,rosaction' : ['re!^', '/'] }
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_collect_identifiers_from_tags_files = 1
    " Let YCM help VimWiki
    let g:ycm_filetype_blacklist = {}
" }
" Folding{
    "let anyfold_activate=1
    autocmd Filetype * AnyFoldActivate
    nmap za zA
" }
" undo tree{
    set undofile
    set undodir=~/yvconf/undo
    nnoremap <leader>u :MundoToggle<CR>
    let g:mundo_width = 60
    let g:mundo_preview_height = 40
" }
" Comments{
    nmap <C-_>   <Plug>NERDCommenterToggle
    vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
    autocmd FileType c setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\s*//'
    autocmd FileType python setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\s*#'
" }
" Relode changes {
     set autoread
     au CursorHold * checktime
" }
" git mergetool {
    if &diff
        map <leader>1 :diffget LOCAL<CR>
        map <leader>2 :diffget BASE<CR>
        map <leader>3 :diffget REMOTE<CR>
    endif
" }
" Easy motions {
    " Remap / to use easy motion
    let g:EasyMotion_do_mapping = 0 " Disable default mappings
    map  / <Plug>(easymotion-sn)
    omap / <Plug>(easymotion-tn)

    " Move to any line
    map <Leader>l <Plug>(easymotion-bd-jk)
    nmap <Leader>l <Plug>(easymotion-overwin-line)
    " Move to word
    map  <Leader>w <Plug>(easymotion-bd-w)
    nmap <Leader>w <Plug>(easymotion-overwin-w)

    " Jump to anywhere you want with minimal keystrokes, with just one key binding.
    " `s{char}{label}`
    nmap s <Plug>(easymotion-overwin-f)
    " or
    " `s{char}{char}{label}`
    " Need one more keystroke, but on average, it may be more comfortable.
    nmap s <Plug>(easymotion-overwin-f2)

    " Turn on case insensitive feature
    let g:EasyMotion_smartcase = 1

    " JK motions: Line motions
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
" }
" Copy global clipboard{
    set clipboard=unnamedplus
" }
" Python running code{
    "imap <Leader>P <Esc>:w<CR>:!clear;python %<CR>
    nnoremap <Leader>p :!clear;python %<CR>
" }
" VimWiki {
    let g:vimwiki_list = [{
                \ 'path': '$HOME/vimwiki/',
                \ 'template_path': '$HOME/vimwiki/templates',
                \ 'template_default': 'default',
                \ 'template_ext': '.html'}]
    let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,br,hr, pre, script'
    nnoremap <leader>c :VimwikiToggleListItem<CR>
    au BufRead,BufNewFile *.wiki set filetype=vimwiki
    function! ToggleCalendar()
      execute ":Calendar"
      if exists("g:calendar_open")
        if g:calendar_open == 1
          execute "q"
          unlet g:calendar_open
        else
          g:calendar_open = 1
        end
      else
        let g:calendar_open = 1
      end
    endfunction
    :autocmd FileType vimwiki map C :call ToggleCalendar()<CR>
" }
" Matrix function{
    function! CreateMatrix(rows, ...) abort
        let cols = a:0 ? a:1 : 3
        let matrix = ['\begin{bmatrix}', join(repeat([repeat('! & ', cols - 1) . '!\\'], a:rows), ""), '\end{bmatrix}' ]
        let matrix = join(matrix, " ")
        call setline('.', getline('.') . matrix)
    endfunction
    command! -nargs=+ Mat silent call CreateMatrix(<f-args>)
" }
" Spell checks{
    set spell
    set spell spelllang=en_us 
    hi clear SpellBad
    hi SpellBad ctermfg=red guifg=red
    hi clear SpellCap
    hi SpellCap ctermfg=Yellow guifg=Yellow
" }
" Command t{
    if &term =~ "xterm" || &term =~ "screen"
        let g:CommandTCancelMap = ['<ESC>', '<C-c>']
    endif
    " Jump remapping
    nmap <Leader>J <Plug>(CommandTJump)
" }
" VDebug{
    function! DebugPy(...)
        let str_args = join(a:000, ' ')
        " command to launch - uses local path to pydbgp, probably this can be done in a better way
        let last_cmd = 'silent !python3 ~/Code/git/Komodo-PythonRemoteDebugging-8.5.4-86985-linux-x86/pydbgp.py -d localhost:9000 ' . str_args . ' &'  
        " start debugging
        python3 debugger.run()
        " launch command in backgound
        execute last_cmd 
    endfunction
    command! -nargs=* DebugPy call DebugPy('% <args>')
" }
" FZF{
    "set rtp+=~/.fzf
" }
" mouse support{
    map <leader>m :exec &mouse!=""? "set mouse=" : "set mouse=nv"<CR>
" }
call vundle#end()   
