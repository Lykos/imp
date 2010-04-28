require "compiler/#{LANGUAGE.downcase}_compiler"

i = 0
while ARGV[i] == "-o" or (i > 0 and ARGV[i - 1] == "-o")
  i += 1
end

if fname = ARGV[i] # Yes! I mean '='!
  input = File.read(fname)
else
  input = ""
  while line = gets # Yes! I mean '='!
    input += line
  end
end

compiler = Compiler.const_get("#{LANGUAGE}Compiler").new(input)
output = compiler.compile

if i = ARGV.index("-o") # Yes! I mean '='!
  File.open(ARGV[i + 1], 'w') { |f| f.puts output }
else
  puts output
end
