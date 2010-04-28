#!/usr/bin/env ruby

puts "Warning! Hardcoded absolute directory path. (Don't worry if you are Bernhard)"
# Ugly hack!!
Dir.chdir('/home/bernhard/Programmiertes/ruby/imp/')
LANGUAGE = "Ruby"

# TODO: Use something else than require.
require 'compiler/compile'
