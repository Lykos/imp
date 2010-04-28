#!/usr/bin/env ruby

puts "Warning! Hardcoded absolute directory path."
# Ugly hack!!
Dir.chdir('/home/bernhard/Programmiertes/ruby/imp/')

require 'interpreter/interpreter'

if ARGV[0]
  file_name = ARGV[0]
  program = File.read(file_name)
else
  program = ""
  while line = gets
    program += line
  end
end
interpreter = Interpreter.new(program)
interpreter.run

puts interpreter.output_variables
