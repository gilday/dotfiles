if [[ "$OSTYPE" == darwin* ]]; then
  local prefix=$(brew --prefix)
  # prepend local ruby to path so it overrides system ruby
  path=("${prefix}/opt/ruby/bin" $path)
  # append local gems to path
  path+="${prefix}/lib/ruby/gems/2.7.0/bin"
fi
