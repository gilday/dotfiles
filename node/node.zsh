if [[ "$OSTYPE" == darwin* ]]; then
  local prefix=$(brew --prefix)
  # prepend local node to path so it overrides system node
  path=("${prefix}/opt/node@20/bin" $path)
fi
