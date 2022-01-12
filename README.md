# SetLocal
SetLocal is a Vim utility for faking buffer-local options for options with only
a global scope.

SetLocal achieves this by changing the global option with BufEnter and
BufLeave events.

## Usage
Enable `virtualedit` for the current buffer with
`call setlocal#set('virtualedit', 'all')`

Clear the "local" option and restore the global option with
`setlocal#clear('virtualedit')`

Check if "local" option is enabled with
`setlocal#get_state('virtualedit')
