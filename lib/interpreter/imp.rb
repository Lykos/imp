#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

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
