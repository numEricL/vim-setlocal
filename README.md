# SetLocal
SetLocal is a vim utility for emulating buffer-local options for vim options
with only a global scope.

SetLocal achieves this by changing the global option with BufEnter and
BufLeave events.

## Usage
Enable `virtualedit` for the current buffer with
`call SetLocal('virtualedit', 'all')`

Clear the "local" option and restore the global option with
`SetLocal_Clear('virtualedit')`

Check if "local" option is enabled with
`SetLocal_GetState('virtualedit')
