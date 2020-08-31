if [[ "$OSTYPE" == darwin* ]]; then
  local prefix=$(brew --prefix)
  # prepend local node to path so it overrides system node
  path=("${prefix}/opt/node@12/bin" $path)
fi
