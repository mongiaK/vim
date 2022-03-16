let g:vimuser = "god"
let g:useremail = "god@sky.com"
let g:urootmarks = ['.svn', '.git', '.root', '.hg', '.project'] 

" 设置插件安装的git地址，github太慢了。
let g:plug_url_format = 'https://git::@hub.fastgit.xyz/%s.git'
call plug#begin('~/.vim/autoload')  " 表示插件安装在~/.vim/autoload 目录

" 自动根据工程文件.svn .git等生成工程的tag索引
Plug 'ludovicchabant/vim-gutentags'

" 显示文件函数，变量
Plug 'majutsushi/tagbar'

" vim 配色库，很多种
Plug 'flazz/vim-colorschemes'

" 目录树
Plug 'scrooloose/nerdtree'

" 异步执行插件
Plug 'skywind3000/asyncrun.vim'

" 搜索工具
Plug 'mileszs/ack.vim'

" 语法检测工具
Plug 'w0rp/ale'

" vim go开发插件
Plug 'fatih/vim-go'

" 注释插件
Plug 'vim-scripts/DoxygenToolkit.vim'

" 格式化插件，依赖于clangformat
Plug 'rhysd/vim-clang-format'

" vim 调试go工程插件
Plug 'sebdah/vim-delve'

" 替代tagbar
Plug 'Yggdroot/LeaderF'

" 补全插件
Plug 'prabirshrestha/async.vim'

" 利用 async.vim 做的补全，相当于一个补全引擎。
Plug 'prabirshrestha/asyncomplete.vim'

" Async Language Server Protocol plugin
Plug 'prabirshrestha/vim-lsp'

" 配合vim-lsp使用，自动配置lsp 识别设置
Plug 'mattn/vim-lsp-settings'

" 将 lsp 中的内容交给 asyncomplete 做补全
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" vim markdown 文件插件
Plug 'plasticboy/vim-markdown'

" markdown 文件预览
Plug 'iamcco/markdown-preview.vim'

" 自动括号，大括号等补全
Plug 'tpope/vim-surround'

" 自动匹配括号等
Plug 'jiangmiao/auto-pairs'

" 状态栏
Plug 'vim-airline/vim-airline'

" 显示函数参数
Plug 'Shougo/echodoc.vim'

" git 修改
Plug 'tpope/vim-fugitive'

" 
Plug 'kien/ctrlp.vim'

call plug#end()

syntax on
set t_Co=256

colorscheme molokai

" 设置文件读的格式,终端格式等等
set fencs=utf-8,gbk 
set termencoding=utf-8
set fileencoding=utf-8
set encoding=utf-8
" 关闭兼容模式
set nocompatible    
" 你输入查找内容的同时，vim就开始对你输入的内容进行匹配，并显示匹配的位置。打开这个选项，你可以即时看到查找的结果。
set incsearch       
" 选项表示在查找时忽略大小写
set ignorecase
" 取消 set nowildmenu，将不能出现tab选择
set wildmenu
" 当检测到一个文件已经在Vim之外被更改，并且它没有在Vim的内部被更改时，自动读取它
set autoread
" 设置光标不要闪烁
set gcr=a:block-blinkon0
" 将状态行显示在窗口底部倒数第二行
set laststatus=2
" 底部的行号等显示
set ruler
" 行号显示(nu)
set number
" 高亮当前行(青色)
set cursorline
" 查询显示高亮
set hlsearch
" 使vi可以用退格键删除
set backspace=indent,eol,start
" 是vim不闪屏
set novisualbell
" 自动缩进时缩进为4格(sw)
set shiftwidth=4
" 启动折叠
" set foldenable
" 启用语法折叠
" set foldmethod=syntax
set nofoldenable
" 语言设置
set langmenu=zn_CN.UTF-8
set helplang=cn
" 高亮显示括号
set showmatch
set matchtime=5
"  不换行
set nowrap
" #开启自动缩进   (ai)
set autoindent
" #编辑时可以将tab替换为空格(et)，输入的不再是tab，而是空格
set expandtab
" 设置tab等于4个空格
set tabstop=4
" 设置当前工程的工作目录，将系统的头文件加进来，方便查看系统函数
set path=.,/usr/include,/usr/local/include
" 设置右下角显示完整命令
" set showcmd
" 设置c语言自动缩进
set cindent
" 设置鼠标可以在普通模式跟可视模式使用
set mouse=nv
" 设置tag索引文件查询目录，当使用gentags时可以去掉该选项
" set tags=tags,../tags,../../tagsset 
" 设置path路径，方便查询系统函数及库函数
set path=.,/usr/include,/usr/local/include,/usr/include/c++/4.4.7,/usr/include/c++/4.4.4

" 设置leader键
let mapleader=','  

func Airline()
    let g:airline_powerline_fonts = 1   " 使用powerline打过补丁的字体
    let g:airline_theme="dark"      " 设置主题
    
    " 开启tabline
    let g:airline#extensions#tabline#enabled = 1      "tabline中当前buffer两端的分隔字符
    let g:airline#extensions#tabline#left_sep = ' '   "tabline中未激活buffer两端的分隔字符
    let g:airline#extensions#tabline#left_alt_sep = '|'      "tabline中buffer显示编号
    let g:airline#extensions#tabline#buffer_nr_show = 1
endfunc

function VimGo()
    let g:go_template_autocreate = 0
    let g:go_template_file = ""
endfunction 
call VimGo()

function GutenTags()
    " --------------- gutentags 配置------------------
    " gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
    let g:gutentags_project_root = g:urootmarks 

    " 所生成的数据文件的名称
    let g:gutentags_ctags_tagfile = '.tags'

    " 同时开启 ctags 和 gtags 支持
    let g:gutentags_modules = []
    if executable('ctags')
	    let g:gutentags_modules += ['ctags']
    endif
       if executable('gtags-cscope') && executable('gtags')
	    let g:gutentags_modules += ['gtags_cscope']
    endif

    " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
    let s:vim_tags = expand('~/.cache/tags')
    let g:gutentags_cache_dir = s:vim_tags
    
    " 调试开关
    " let g:gutentags_trace = 1

    " 配置 ctags 的参数
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

    " 检测 ~/.cache/tags 不存在就新建
    if !isdirectory(s:vim_tags)
        silent! call mkdir(s:vim_tags, 'p')
    endif
endfunction
call GutenTags()

function Nerdtree()
    "  右侧显示文件树
    let g:NERDTreeWinPos=0
    let g:NERDTreeHighlightCursorline = 1
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeDirArrows = 1
    let g:NERDTreeShowBookmarks=1
    let g:NERDTreeShowHidden=1
endfunction 
call Nerdtree()

function Tagbar()
    " 左侧显示函数
    let g:tagbar_left = 0
    " tagbar 设置
    let g:tagbar_width = 30
    
    nmap <leader>t :Tagbar<CR>
endfunction 
" call Tagbar()

function Ale()
    let g:ale_sign_column_always = 0  " 侧边栏不可见，只有错误的时候才显示
    let g:ale_set_highlights = 0
    "自定义error和warning图标
    let g:ale_sign_error = '✗'
    let g:ale_sign_warning = '⚡'
    "在vim自带的状态栏中整合ale
    let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
    "显示Linter名称,出错或警告等相关信息
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

    " ------------------  ale cpp ---------------------------
    let g:ale_cpp_clang_options = '-std=c++11 -Wall'
    let g:ale_cpp_gcc_options = '-std=c++11 -Wall'

    " ------------------  ale c   --------------------------
    let b:ale_c_parse_makefile = 1
    let g:ale_c_parse_compile_commands = 0
    "

    " 不开启文件变了就立刻检查
    let g:ale_lint_on_text_changed = 'never'
    " let g:ale_lint_on_insert_leave = 1
    " let g:ale_lint_on_enter = 1 
    " let g:ale_completion_enabled = 1  "  开启自动补全
    " let g:ale_lint_on_save = 1

    " 设置语法检测
    let g:ale_linters = {
                \   'cpp': ['gcc'],
                \   'c': ['gcc'],
                \   'python': ['pylint'],
                \   'go': ['gometalinter', 'gofmt', 'golint'],
                \   'javascript': ['eslint'],
                \   'jsx': ['stylelint', 'eslint'],
                \}
    " 设置代码格式化
    let g:ale_fixers = {
                \   'javascript': ['prettier'],
                \   'css': ['prettier'],
                \   'jsx': ['prettier'],
                \}
endfunction 
cal Ale()

function BuildComment()
    " 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数
    autocmd BufNewFile *.[ch],*.hpp,*.cpp,*.cc,Makefile,*.mk,*.sh,*.go,*.py exec ":call SetTitle()"
endfunction 
call BuildComment()

" 加入注释
function Comment(start_line, label)
    if a:label == "*"
        call setline(a:start_line, "/*================================================================")
    elseif a:label == "#"
        call setline(a:start_line, "#=================================================================")
    endif

    call setline(a:start_line + 1, a:label."  ")
    call setline(a:start_line + 2, a:label."  文件名称：".expand("%:t"))
    call setline(a:start_line + 3, a:label."  创 建 者: ".g:vimuser)
    call setline(a:start_line + 4, a:label."  创建日期：".strftime("%Y年%m月%d日"))
    call setline(a:start_line + 5, a:label."  邮    箱：".g:useremail)
    call setline(a:start_line + 6, a:label."  ")

    if a:label == "*"
        call setline(a:start_line + 7, "================================================================*/")
    elseif a:label == "#"
        call setline(a:start_line + 7, "#=================================================================")
    endif

    call setline(a:start_line + 8, "")
endfunction

" 定义函数SetTitle，自动插入文件头 
function SetTitle()
	if &filetype == 'make'
		call Comment(1, "#")
	elseif &filetype == 'sh' 
		call setline(1,"#!/bin/bash") 
		call setline(2,"")
        call Comment(3, "#")
	else
        if expand("%:e") == 'hpp' 
            call Comment(1, "*")
            call setline(10, "#ifndef __".toupper(expand("%:t:r"))."_H__") 
            call setline(11, "#define __".toupper(expand("%:t:r"))."_H__") 
            call setline(12, "#ifdef __cplusplus") 
            call setline(13, "extern \"C\"") 
            call setline(14, "{") 
            call setline(15, "#endif") 
            call setline(16, "") 
            call setline(17, "#ifdef __cplusplus") 
            call setline(18, "}") 
            call setline(19, "#endif") 
            call setline(20, "#endif //".toupper(expand("%:t:r"))."_H") 
        elseif expand("%:e") == 'h' 
            call Comment(1, "*")
            call setline(10, "#pragma once") 
        elseif expand("%:e") == 'py'
            call setline(1,"#!/usr/bin/python")
            call setline(2,"# -*- coding: utf-8 -*- ")
            call Comment(3, "#")
        elseif expand("%:e") == 'go'
            call Comment(1, "*")
        elseif &filetype == 'c' 
            call Comment(1, "*")
            call setline(10, "#include \"".expand("%:t:r").".h\"") 
        elseif &filetype == 'cpp'
            call Comment(1, "*")
            call setline(10, "#include \"".expand("%:t:r").".h\"")
        elseif &filetype == 'cc'
            call Comment(1, "*")
            call setline(10, "#include \"".expand("%:t:r").".h\"")
        endif
    endif
endfunction

function Doxygen()
    let g:DoxygenToolkit_briefTag_funcName = "yes"
    " for C++ style, change the '@' to '\'
    let g:DoxygenToolkit_commentType          = "C++"
    let g:DoxygenToolkit_briefTag_pre         = "brief "
    let g:DoxygenToolkit_templateParamTag_pre = "tparam "
    let g:DoxygenToolkit_paramTag_pre         = "param "
    let g:DoxygenToolkit_returnTag            = "return "
    let g:DoxygenToolkit_throwTag_pre         = "throw " " @exception is also valid
    let g:DoxygenToolkit_fileTag              = "file "
    let g:DoxygenToolkit_dateTag              = "date "
    let g:DoxygenToolkit_authorTag            = "author "
    let g:DoxygenToolkit_versionTag           = "version "
    let g:DoxygenToolkit_blockTag             = "name "
    let g:DoxygenToolkit_classTag             = "class "
    let g:DoxygenToolkit_authorName           = g:vimuser
    let g:doxygen_enhanced_color              = 1
    let g:DoxygenToolkit_blockHeader          = "/****************************************************************************"
    let g:DoxygenToolkit_blockFooter          = "****************************************************************************/"
    let g:DoxygenToolkit_startCommentTag      = ""
    let g:DoxygenToolkit_interCommentTag      = "*"
    let g:DoxygenToolkit_endCommentTag        = ""
    let g:DoxygenToolkit_startCommentBlock    = ""
    let g:DoxygenToolkit_interCommentBlock    = "* "
    let g:DoxygenToolkit_endCommentBlock      = ""
endfunction
call Doxygen()

" autocmd! 删除自动命令
" autocmd 监听指定命令做相应操作
function LspSetting()
    let g:lsp_settings_servers_dir='~/.vim/vim-lsp-settings/servers'
    let g:asyncomplete_auto_completeopt = 1
    
    " noselect 触发补全不选第一个
    " noinsert
    " menuone
    " preview 触发补全选择第一个
    set completeopt=menuone,noinsert,noselect " preview
    
    " pumvisible, popup menu 窗口存在返回非0，否则返回0
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"
    " 回撤按下，如果popup窗口存在则关闭，否则就正常执行回撤
    inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"

    " 注册python的lsp server到lsp setting，补全使用
    if executable('pyls')
        " pip install python-language-server
        au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
    endif

    " 注册bash的lsp server
    if executable('bash-language-server')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'bash-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
            \ 'whitelist': ['sh'],
            \ })
    endif

    if executable('clangd')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', '.h', '.hpp', '.cc'],
            \ })
    endif

endfunction
call LspSetting()

function Ack()
    cnoreabbrev Ack Ack!
    let g:ackprg = 'ag --nogroup --nocolor --column'
endfunction
call Ack()

function AsyncRun()
    " 如果递归到根目录还没找到，那么文件所在目录就被当作项目目录。
    let g:asyncrun_rootmarks = g:urootmarks 
    " 自动打开 quickfix window ，高度为 8
    let g:asyncrun_open = 8
endfunction
call AsyncRun()

function VimDelve()
    let g:delve_new_command = 'new'
endfunction 
call VimDelve()

function EchoDoc()
    " Or, you could use vim's popup window feature.
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'popup'
    " To use a custom highlight for the popup window,
    " change Pmenu to your highlight group
    highlight link EchoDocPopup Pmenu
endfunction
call EchoDoc()

function MLeaderF()
    let g:Lf_ShortcutF = '<leader>f'
    let g:Lf_RootMarkers = g:urootmarks
    let g:Lf_DefaultExternalTool = 'ag'
    let g:Lf_WindowHeight = 0.30
    let g:Lf_ctags = 'gtags'

    if has('nvim')
        let s:cachedir = expand(stdpath('cache'))
    else
        "vim will share same folder with nvim
        if has('win32')
            let s:cachedir = expand('~/AppData/Local/Temp/cache/vim')
        else
            let s:cachedir = expand('~/.cache/vim')
        endif
    endif

    let g:Lf_CacheDirectory = s:cachedir
endfunction
call MLeaderF()

"Command命令	常规模式	可视化模式	运算符模式	插入模式	命令行模式
":map	            √	        √	        √	 	 
":nmap	            √	 	 	 	 
":vmap	 	                    √	 	 	 
":omap	 	 	                            √	 	 
":map!	 	 	 	                                    √	        √
":imap	 	 	 	                                    √	 
":cmap	 	 	 	 	                                            √
" <Esc>代表Escape键:<CR>代表Enter键；<D>代表Command键。
" Alt键可以使用<M-key>或<A-key>来表示。<C>代表Ctrl.
" 对于组合键，可以用<C-Esc>代表Ctrl-Esc；使用<S-F1>表示Shift-F1
" % 当前完整的文件名
" %:h 文件名的头部，即文件目录.例如../path/test.c就会为../path
" %:t 文件名的尾部.例如../path/test.c就会为test.c
" %:r 无扩展名的文件名.例如../path/test就会成为test
" %:p 绝对路径
" %:e 扩展名
" map 可以递归映射，noremap 非递归映射

" 特殊参数
" <buffer> : 映射只局限在当前缓冲区
" <silent> : 执行按键绑定不再命令行显示
" <special>: 用于定义特殊键怕有副作用的场合
" <expr>   : 如果定义新映射的第一个参数是<expr>，那么参数会作为表达式来进行计算，结果使用实际使用的
" <unique> : 检测新的键映射是否存在，存在则失败

function LeaderfShortKey()
    noremap <leader-l>f :LeaderfFunction<CR>
endfunction
call LeaderfShortKey()

function NerdTreeShortKey()
    nmap <C-n>o :NERDTree<CR>
    nmap <C-n>c :NERDTreeClose<CR>
endfunction
call NerdTreeShortKey()

function BasicShortKey()
    nmap <S-f> :ClangFormat <CR>
    nmap <S-a> :Ack <cword><CR>
    nmap <S-q> :q!<CR>
    nmap <F6> :call asyncrun#quickfix_toggle(8)<CR>
endfunction
call BasicShortKey()

function CShortKey()
    " 快捷键 配置 <C-R>插入寄存器数据，=是vim的特殊寄存器
    nmap <C-h> :vsp <C-R>=expand('%:p:r').'.h'<CR><CR>
    nmap <C-p> :vsp <C-R>=expand('%:p:r').'.cpp'<CR><CR>
    nmap <C-c> :vsp <C-R>=expand('%:p:r').'.c'<CR><CR>
    
    " 设置 F5 从工程根目录编译整个工程 
    nmap <silent> <F5> :AsyncRun -cwd=<root> make -j8 <CR>
endfunction
call CShortKey()

function AleShortKey()
    nmap <C-a>p <Plug>(ale_previous_wrap)
    nmap <C-a>n <Plug>(ale_next_wrap)
    nmap <C-a>d :ALEDetail<CR>
    nmap <C-a>i :ALEInfo<CR>
endfunction
call AleShortKey()

function GoShortKey()
    nmap <C-g>b :GoBuild<CR>
    nmap <C-g>r :GoRun<CR>
    nmap <C-g>i :GoImports<CR>
    
    nmap <C-g>F3 :DlvAddBreakpoint<CR>
    nmap <C-g>F4 :DlvRemoveBreakpoint<CR>
    nmap <C-c>F5 :DlvDebug<CR>
endfunction
call GoShortKey()

function SurroundShortKey()
    nmap <C-s>d <Plug>Dsurround
    nmap <C-s>c <Plug>Csurround
    imap <C-s>g <Plug>Isurround
endfunction
call SurroundShortKey()

autocmd! bufwritepost $HOME/.vimrc source %
