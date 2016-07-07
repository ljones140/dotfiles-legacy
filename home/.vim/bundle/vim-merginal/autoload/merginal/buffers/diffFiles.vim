call merginal#modulelib#makeModule(s:, 'diffFiles', 'base')

function! s:f.init(diffTarget) dict abort
    let self.diffTarget = a:diffTarget
endfunction

function! s:f.generateHeader() dict abort
    return [
                \ '=== Diffing With: ===',
                \ self.diffTarget,
                \ '=====================',
                \ '']
endfunction

function! s:f.generateBody() dict abort
    let l:diffFiles = self.gitLines('diff', '--name-status', self.diffTarget)
    return l:diffFiles
endfunction

function! s:f.diffFileDetails(lineNumber) dict abort
    call self.verifyLineInBody(a:lineNumber)

    let l:line = getline(a:lineNumber)
    let l:result = {}

    let l:matches = matchlist(l:line, '\v([ADM])\t(.*)$')

    if empty(l:matches)
        throw 'Unable to get diff files details for `'.l:line.'`'
    endif

    let l:result.isAdded = 0
    let l:result.isDeleted = 0
    let l:result.isModified = 0
    if 'A' == l:matches[1]
        let l:result.type = 'added'
        let l:result.isAdded = 1
    elseif 'D' == l:matches[1]
        let l:result.type = 'deleted'
        let l:result.isDeleted = 1
    else
        let l:result.type = 'modified'
        let l:result.isModified = 1
    endif

    let l:result.fileInTree = l:matches[2]
    let l:result.fileFullPath = self.repo.tree(l:matches[2])

    return l:result
endfunction


function! s:f.openDiffFileUnderCursor() dict abort
    let l:diffFile = self.diffFileDetails('.')

    if l:diffFile.isDeleted
        throw 'File does not exist in current buffer'
    endif

    call merginal#openFileDecidedWindow(self.repo, l:diffFile.fileFullPath)
endfunction
call s:f.addCommand('openDiffFileUnderCursor', [], 'MerginalOpen', '<Cr>', 'Open the file under the cursor (if it exists in the currently checked out branch).')


function! s:f.openDiffFileUnderCursorAndDiff(diffType) dict abort
    if a:diffType!='s' && a:diffType!='v'
        throw 'Bad diff type'
    endif

    let l:diffFile = self.diffFileDetails('.')

    if l:diffFile.isAdded
        throw 'File does not exist in other buffer'
    endif

    "Close currently open git diffs
    let l:currentWindowBuffer = winbufnr('.')
    try
        windo if 'blob' == get(b:,'fugitive_type','') && exists('w:fugitive_diff_restore')
                    \| bdelete
                    \| endif
    catch
        "do nothing
    finally
        execute bufwinnr(l:currentWindowBuffer).'wincmd w'
    endtry

    call merginal#openFileDecidedWindow(self.repo, l:diffFile.fileFullPath)

    execute ':G'.a:diffType.'diff '.fnameescape(self.diffTarget)
endfunction
call s:f.addCommand('openDiffFileUnderCursorAndDiff', ['s'], 'MerginalDiff', 'ds', 'Split-diff against the file under the cursor (if it exists in the other branch)')
call s:f.addCommand('openDiffFileUnderCursorAndDiff', ['v'], 'MerginalVDiff', 'dv', 'VSplit-diff against the file under the cursor (if it exists in the other branch)')


function! s:f.checkoutDiffFileUnderCursor() dict abort
    let l:diffFile = self.diffFileDetails('.')

    if l:diffFile.isAdded
        throw 'File does not exist in diffed buffer'
    endif

    let l:answer = 1
    if !empty(glob(l:diffFile.fileFullPath))
        let l:answer = 'yes' == input('Override `'.l:diffFile.fileInTree.'`? (type "yes" to confirm) ')
    endif
    if l:answer
        call self.gitEcho('checkout', self.diffTarget, '--', l:diffFile.fileFullPath)
        call merginal#reloadBuffers()
        call self.refresh()
    else
        echo
        echom 'File checkout canceled by user.'
    endif
endfunction
call s:f.addCommand('checkoutDiffFileUnderCursor', [], 'MerginalCheckoutDiffFile', 'co', 'Check out the file under the cursor (if it exists in the other branch) into the current branch.')
