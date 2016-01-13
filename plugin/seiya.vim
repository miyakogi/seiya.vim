if exists('g:loaded_seiya')
  finish
endif
let g:loaded_seiya = 1

let s:save_cpo = &cpo
set cpo&vim

let g:seiya_target_groups = get(g:, 'seiya_target_groups', ['ctermbg'])

function! s:clear_bg(hl)
  for group in g:seiya_target_groups
    execute 'highlight ' . a:hl . ' ' . group . '=None'
  endfor
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

augroup seiya_auto
  if get(g:, 'seiya_auto_enable', 0)
    autocmd VimEnter * execute "call s:clear_auto()"
  endif
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:set ts=2:set sw=2:
