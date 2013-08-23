set compatible
"source $VIMRUNTIME/vimrc_example.vim "软件安装时默认配置，source入vimrc_example.vim后，在设置encoding=utf-8时，将导致中文菜单乱码难以解决
source $VIMRUNTIME/mswin.vim
behave mswin

" 字体、字号
set guifont=Courier\ New:h14

" 编码设置
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set ffs=unix,dos,mac
set ff=unix               "设置文件格式为UNIX格式

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
"================================

syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on
set tabstop=4                " 设置tab键的宽度
set shiftwidth=4             " 换行时行间交错使用4个空格
set autoindent               " 自动对齐
set backspace=2              " 设置退格键可用
set cindent shiftwidth=4     " 自动缩进4空格
set smartindent              " 智能自动缩进
set ai!                      " 设置自动缩进
set nu!                      " 显示行号
set showmatch               " 显示括号配对情况
set mouse=a                  " 启用鼠标
set ruler                    " 右下角显示光标位置的状态行
set incsearch                " 查找book时，当输入/b时会自动找到
set hlsearch                 " 开启高亮显示结果
set incsearch                " 开启实时搜索功能
set nowrapscan               " 搜索到文件两端时不重新搜索
set nocompatible             " 关闭兼容模式
set vb t_vb=                 " 关闭提示音
set hidden                   " 允许在有未保存的修改时切换缓冲区

if has("gui_running")
    au GUIEnter * simalt ~x  " 窗口启动时自动最大化
    "set guioptions-=m       " 隐藏菜单栏
    "set guioptions-=T        " 隐藏工具栏
    set guioptions-=L       " 隐藏左侧滚动条
    "set guioptions-=r       " 隐藏右侧滚动条
    "set guioptions-=b       " 隐藏底部滚动条
    "set showtabline=0       " 隐藏Tab栏
endif

set writebackup              " 设置无备份文件
set nobackup
set autochdir                " 设定文件浏览器目录为当前目录
"设定代码折叠
"set nowrap                  " 设置不自动换行
set foldmethod=syntax        " 选择代码折叠类型
set foldlevel=100            " 禁止自动折叠


" For Haskell
:let hs_highlight_delimiters=1            " 高亮定界符
:let hs_highlight_boolean=1               " 把True和False识别为关键字
:let hs_highlight_types=1                 " 把基本类型的名字识别为关键字
:let hs_highlight_more_types=1            " 把更多常用类型识别为关键字
:let hs_highlight_debug=1                 " 高亮调试函数的名字
:let hs_allow_hash_operator=1             " 阻止把#高亮为错误

set laststatus=2                          " 开启状态栏信息
set cmdheight=1                           " 命令行的高度，默认为1，这里可以重设

" 状态行显示的内容 [包括系统平台、文件类型、坐标、所占比例、时间等]
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %y%r%m%*%=\ %{strftime(\"%y/%m/%d\ -\ %H:%M\")}
"12/03/13
au BufRead,BufNewFile *.js set syntax=jquery    "添加jquery配色支持
let b:javascript_fold=1   " 打开javascript折叠
let javascript_enable_domhtmlcss=1      " 打开javascript对dom、html和css的支持
"正常模式下单击wm即可打开窗口浏览器
let g:winManagerWindowLayout='FileExplorer'
nmap wm :WMToggle<cr>
"也可以使用NERDTree这个插件浏览文件路径
nmap ne :NERDTree<cr>
nmap nc :NERDTreeClose<cr>
"用nh去掉查找后的高亮
nmap nh :noh<cr>
"另存为
nmap ss :browse confirm saveas<cr>
"新建标签
nmap <C-N> :tabnew<CR>
"自动将 Vim 工作目录迁移到所打开文本文件的目录下
autocmd BufEnter * cd %:p:h
"用Ctrl+PageUp/PageDown切换标签页
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>
"按F8、F9切换标签页
nnoremap <silent> <F8> :tabp<CR>
nnoremap <silent> <F9> :tabn<CR>
"按F12关闭当前标签
nnoremap <silent> <F12> :tabc<CR>
"Alt+n 切换标签页
function! BufPos_ActivateBuffer(num)
    let l:count = 1
    for i in range(1, bufnr("$"))
        if buflisted(i) && getbufvar(i, "&modifiable")
            if l:count == a:num
                exe "buffer " . i
                return
            endif
            let l:count = l:count + 1
        endif
    endfor
    echo "No buffer!"
endfunction

function! BufPos_Initialize()
    for i in range(1, 9)
        exe "map <M-" . i . "> :call BufPos_ActivateBuffer(" . i . ")<CR>"
    endfor
    exe "map <M-0> :call BufPos_ActivateBuffer(10)<CR>"
endfunction
autocmd VimEnter * call BufPos_Initialize()

"标签页栏中去除当前所编辑文件的路径信息，只保留文件名
function ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
    let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction
set guitablabel=%{ShortTabLabel()}

"gvim 按F2显隐菜单及工具栏
set guioptions-=m
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
"<F5>显示目录,<F6>关闭目录<F2><F2>
nnoremap <silent> <F5> :NERDTree<CR>
nnoremap <silent> <F6> :NERDTreeClose<CR>
" winManager 设置
"let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent> <leader>wm :WMToggle<cr> 
"定制ZenCoding,用Ctrl+e替换ctrl+y+,展开表达式
let g:user_zen_settings = {
 \ 'php' : {
 \ 'extends' : 'html',
 \ 'filters' : 'c',
 \ },
 \ 'xml' : {
 \ 'extends' : 'html',
 \ },
 \ 'html' : {
 \ 'extends' : 'html',
 \ },
 \}
  let g:user_zen_expandabbr_key = '<c-e>'
  let g:use_zen_complete_tag = 1

