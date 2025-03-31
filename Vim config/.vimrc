call plug#begin('~/.vim/plugged')

" IntelliSense for C++ (clangd)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax checking
Plug 'dense-analysis/ale'

" Syntax Highlighter
Plug 'sheerun/vim-polyglot'

" Catpuccin Theme for text
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

" File Explorer
Plug 'preservim/nerdtree'

" Status Line Pluggin
Plug 'vim-airline/vim-airline'

call plug#end()

" Enable LSP (clangd) for C++
let g:coc_global_extensions = ['coc-clangd']

" Keybindings
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-a> :ALEToggle<CR>

" Autocomplete with Tab
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" Load the theme
colorscheme catppuccin_mocha
set termguicolors
let g:catppuccin_flavour = "mocha"

" Turn off catpuccin background 
autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE
autocmd VimEnter * hi NonText guibg=NONE ctermbg=NONE
autocmd VimEnter * hi LineNr guibg=NONE ctermbg=NONE
autocmd VimEnter * hi SignColumn guibg=NONE ctermbg=NONE

" Copy
vnoremap <C-c> :w !wl-copy<CR><CR>

" Set dark background
set background=dark

" Fix completion menu colors
highlight Pmenu guibg=black guifg=white
highlight PmenuSel guibg=gray guifg=black

" Omnisharp for C#
let g:OmniSharp_server_stdio = 1
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
let g:ale_linters = {
			\ 'cs': ['OmniSharp'],
			\ 'cpp': ['cc','gcc','clang']
			\}
let g:ale_fixers = {
			\ 'cs': ['omnisharp_code_format'],
			\ 'cpp': ['clang-format']
			\}
let g:ale_completion_enabled = 1

" Show ALE error messages in the Vim status line
let g:ale_echo_msg_format = '[%linter%] %s'

" Remove solid background
highlight Normal guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE
highlight NormalNC guibg=NONE ctermbg=NONE

" Add Side count
set number
let g:airline_theme = 'catppuccin_mocha'

" CPP-SETTINGS:
" Lint .h files as C++, not C
let g:ale_pattern_options_enabled = 1
let g:ale_pattern_options = { '\.h$': { 'ale_linters': { 'cpp' : ['cc', 'gcc', 'clang'] } } }
let g:ale_sign_warning = 0
let g:ale_echo_warning = 0
let g:ale_virtualtext_cursor = 0

" Set flags for gcc/clang
let cpp_opts = '-std=c++20 -Wall -Wextra'
let g:ale_cpp_cc_options    = cpp_opts
let g:ale_cpp_gcc_options   = cpp_opts
let g:ale_cpp_clang_options = cpp_opts

" For Unity Refresh command
command! Re OmniSharpRestartAllServers | CocRestart
