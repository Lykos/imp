require 'parser/syntactic_parser'

module Compiler
  # Represents an IMP to Ruby compiler.
  #
  class IMPCompiler
    def initialize(program)
      parser = Parser::SyntacticParser.new(program)
      @ast = parser.ast
    end

    attr_reader :output

    # Return the compiled Ruby output.
    #
    def compile
      @output = @ast.to_s
    end
  end
end
