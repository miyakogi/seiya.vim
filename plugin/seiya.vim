if exists('g:loaded_seiya')
  finish
endif
let g:loaded_seiya = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:clear_bg(hl)
  call s:save_hl(a:hl)
  execute "highlight " . a:hl . " ctermbg=None"
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

command! SeiyaEnable call s:clear_bg_all()
command! SeiyaAutoEnable call s:clear_auto()
command! SeiyaAutoDisable autocmd! seiya_auto

if get(g:, 'seiya_auto_enable', 0)
  augroup seiya
    autocmd VimEnter * execute "call s:clear_auto() | autocmd! clear_bg_auto_enable"
  augroup END
endif

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:set ts=2:set sw=2:
