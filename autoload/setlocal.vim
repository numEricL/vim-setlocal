function setlocal#set(opt, val) abort
    call s:OptionOn(a:opt, a:val)
    call s:AugroupOn(a:opt, a:val)
endfunction

function setlocal#clear(opt) abort
    call s:OptionOff(a:opt)
    call s:AugroupOff(a:opt)
endfunction

function setlocal#get_state(opt) abort
    let l:option = 'b:SetLocal_options['.string(a:opt).']'
    return exists(l:option) && get(eval(l:option), 'state')
endfunction

function s:OptionOn(opt, val) abort
    if !exists('b:SetLocal_options')
        let b:SetLocal_options = {}
    endif
    if !has_key(b:SetLocal_options, a:opt) || !b:SetLocal_options[a:opt]['state']
        execute 'let l:revert = &'.a:opt
        let b:SetLocal_options[a:opt] = {'state':1, 'revert': l:revert}
    endif

    execute 'let &'.a:opt.'='.string(a:val)
endfunction

function s:OptionOff(opt) abort
    if !b:SetLocal_options[a:opt]['state']
        return
    endif

    execute 'let &'.a:opt.'='.string(b:SetLocal_options[a:opt]['revert'])
    let b:SetLocal_options[a:opt] = {'state':0, 'revert':''}
endfunction

function s:AugroupOn(opt, val) abort
    if !exists('b:SetLocal_augroup')
        let b:SetLocal_augroup = {}
    endif

    let b:SetLocal_augroup[a:opt] = {'name': "SetLocal_".a:opt, 'state': 1}
    execute "augroup ".b:SetLocal_augroup[a:opt]['name']
    execute "autocmd BufEnter <buffer> call s:OptionOn(".string(a:opt).",".string(a:val).")"
    execute "autocmd BufLeave <buffer> call s:OptionOff(".string(a:opt).")"
augroup END
endfunction

function s:AugroupOff(opt) abort
    let b:SetLocal_augroup[a:opt]['state'] = 0
    execute "autocmd! ".b:SetLocal_augroup[a:opt]['name']." * <buffer>"
endfunction
