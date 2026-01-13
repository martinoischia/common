vim9script
if exists('g:after_dart_vim_loaded')
  finish
endif
g:after_dart_vim_loaded = true

# setl formatprg=dart\ format

# def JobStdout(job: channel, data: string)
  # echom 'STDOUT: '
	   # .. data
# enddef

# def JobStderr(job: channel, data: string)
#   echom 'STDERR: ' .. data
# enddef

def JobExit(job: job, status: number)
  edit
enddef

def FormatFile()
  var filepath = expand('%:p')
  if empty(filepath)
    echom "No file to format"
    return
  endif
  job_start(['dart.bat', 'format', expand('%:p')], {exit_cb: JobExit})
enddef
#	  out_cb: JobStdout,
#	  err_cb: JobStderr,

augroup FormatOnSave
  autocmd!
  autocmd BufWritePost *.dart call FormatFile()
augroup END
