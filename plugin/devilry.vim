function! s:setDevilrySettings()
    " Run tests using :make <args to test>
    compiler pyunit
    setlocal makeprg=python\ ~/code/devilry-django/devilry/projects/dev/manage.py\ test
endfunction

function! s:setDevilrySettingsIfInDevilry()
    let l:pathToCurrentFile = expand("%:p")
    " Check if path contains devilry
    if l:pathToCurrentFile =~ "devilry"
        call s:setDevilrySettings()
    endif
endfunction

au BufRead,BufNewFile *.py call s:setDevilrySettingsIfInDevilry()
