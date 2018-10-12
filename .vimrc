" Vaibhav Arcot's vimrc file
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
Plugin 'jonstoler/werewolf.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'rhysd/vim-grammarous'
Plugin 'vim-syntastic/syntastic'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-unimpaired'
Plugin 'taketwo/vim-ros'
Plugin 'pseewald/vim-anyfold'
Plugin 'Raimondi/delimitMate'
Plugin 'inkarkat/vim-ingo-library'
Plugin 'inkarkat/vim-spellcheck'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'bling/vim-bufferline'
Plugin 'airblade/vim-gitgutter'
Plugin 'sickill/vim-pasta'
filetype plugin indent on    " required

" New leader
let mapleader="\<SPACE>"
" Tab {
	set tabstop=4        " tab width is 4 spaces
	set shiftwidth=4     " indent also with 4 spaces
	set expandtab        " replaces tab with spaces
" }
" Visual mode
	nnoremap <leader><leader> V
" }
" Splits {
	nnoremap <leader>' :sp<CR>
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
" }
" qq to record, q to stop, Q to use 
" learn dynamic macros{
	nnoremap Q @q
	vnoremap Q :norm @q<cr>
"}
" line numers are for plebs {
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
	set ttimeoutlen=50 " sets a timeour to help speed it up
    set backspace=indent,eol,start
"}
" Quit current file
	noremap <leader>q :q<cr>
" Format file \f
map <F7> mzgg=G`z
" Save with CTRL-S both in insert and command mode{
	map <C-s> :w<CR>
	imap <C-s> <Esc>:w<CR>
"}
"lightline {
	set laststatus=2
	let g:lightline = { 'colorscheme':'wombat',
			\     'active': {
			\         'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'filename', 'modified']],
			\         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
			\     },'component_function':{
			\	'gitbranch':'fugitive#head'},
			\}
" }
"Nerdtree {
	map <leader>f :NERDTreeToggle<CR>
	let NERDTreeShowHidden=1
" }
" No annoying sound on errors {
	set noerrorbells
	set novisualbell
	set t_vb=
	set tm=500
"}
" Indentation {
	set ai "Auto indent
	set si "Smart indent
	set wrap "Wrap lines
" }
" Color settings{
	syntax on
	set t_Co=256
	let g:gruvbox_italic=1
	color gruvbox
	set background=dark
"}
" All of your Plugins must be added before the following line
" Syntastic {
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
" }
" Folding{
	let anyfold_activate=1
	set foldlevel=0
	nmap za zA
" }
call vundle#end()            " required
