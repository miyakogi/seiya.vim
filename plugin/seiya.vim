if exists('g:loaded_seiya')
  finish
endif
let g:loaded_seiya = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:clear_bg(hl)
  execute 'highlight ' . a:hl . ' ctermbg=None'
endfunction

function! s:clear_bg_all()
  call s:clear_bg('Normal')
  call s:clear_bg('LineNr')
  " call s:clear_bg('Folded')
  call s:clear_bg('SignColumn')
  call s:clear_bg('VertSplit')
  call s:clear_bg('NonText')
endfunction

function! s:clear_auto()
  call s:clear_bg_all()
  augroup seiya_auto
    autocmd!
    autocmd ColorScheme * call s:clear_bg_all()
  augroup END
endfunction

function! s:disable()
  autocmd! seiya_auto
  let l:colors_name = get(g:, 'colors_name', '')
  echomsg l:colors_name
  if l:colors_name !=# ''
    try
      execute 'colorscheme ' . l:colors_name
    endtry
  endif
endfunction

command! SeiyaEnable call s:clear_auto()
command! SeiyaDisable call s:disable()

if get(g:, 'seiya_auto_enable', 0)
  augroup seiya
    autocmd VimEnter * execute "call s:clear_auto()"
  augroup END
endif

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:set ts=2:set sw=2:
