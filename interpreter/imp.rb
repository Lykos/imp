#!/usr/bin/env ruby

puts "Warning! Hardcoded absolute directory path. (Don't worry if you are Bernhard)"
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
interpreter = Interpreter::Interpreter.new(program)

i = 1
while ARGV[i]
  variable = ARGV[i]
  value = ARGV[i+1].to_i
  # TODO: Useful error messages.
  interpreter.set_variable(variable, value)
  i += 2
end

interpreter.run

puts interpreter.output_variables
