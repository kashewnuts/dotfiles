if has('conceal')   " http://yuzuemon.hatenablog.com/entry/2015/01/15/035759
  setlocal conceallevel=0 " Always display quotes
endif
if executable('python3')
  setlocal equalprg="python3 -c 'import sys,json;print json.dumps(json.loads(sys.stdin.read()),ensure_ascii=False,indent=2)'"
endif
