""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE:
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE:
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope") && executable("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add cscope database
    set nocscopeverbose
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let db_path = strpart(db, 0, match(db, "/cscope.out$"))
        exe "cs add " . db . " " . db_path
        " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose

    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "

    nmap <leader>cs :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>cg :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>ct :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>ce :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>cf :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader>ci :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <leader>cd :cs find d <C-R>=expand("<cword>")<CR><CR>

    nmap <leader>ss :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sg :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sc :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>st :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>se :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sf :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader>si :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <leader>sd :scs find d <C-R>=expand("<cword>")<CR><CR>

    nmap <leader>vs :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>vg :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>vc :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>vt :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>ve :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>vf :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader>vi :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <leader>vd :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif
