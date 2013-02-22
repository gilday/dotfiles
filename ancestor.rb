#!/usr/bin/env ruby

# Little script for climbing up a directory hierarchy until we are in a directory with a given name
# This is useful for really deep Java source directories when I want to get back to 'src'
# It stops when it finds your home directory or root. In these cases, it will bring you back to the folder you executed from
#
#
# TODO Refactor this. There's no reason to walk up the whole directory tree I could just get the current directory and hack the string up to match the directory I want to go to and it would be way more efficient
#
require 'pathname'

target = ARGV[0]
if(target.to_s.empty?)
  puts "Need an argument"
  exit 1
end

originalDir = Dir.pwd
dir = originalDir

while target != File.basename(dir) && dir != ENV["HOME"] && dir != '/' 
  Dir.chdir '..'
  dir = Dir.pwd
end

if File.basename(dir) != target
  puts "Could not find #{target}"
  exit 1
end
puts Dir.pwd

