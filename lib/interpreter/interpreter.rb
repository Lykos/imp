require 'forwardable'

require 'parser/syntactic_parser'
require 'interpreter/context'

module Interpreter
  # Represents an interpreter for IMP that is able to interpret a given string.
  #
  class Interpreter
  
    extend Forwardable
  
    # Initializes a new interpreter with a given string.
    #
    def initialize(program)
      syntactic_parser = Parser::SyntacticParser.new(program)
      @ast = syntactic_parser.ast
      @context = Context.new
    end
  
    attr_reader :ast, :context
  
    def_delegators :@context, :set_variable, :get_variable, :output_variables
  
    def run
      @ast.interpret(@context)
    end
  end
end
