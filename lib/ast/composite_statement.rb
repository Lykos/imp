require 'ast/statement'

module AST
  # Represents a composite statement that consits of many simple statements.
  #
  class CompositeStatement < Statement
  
    # Initializes a given composite statement with an array of statements.
    #
    def initialize(statements)
      @statements = statements
    end
  
    attr_reader :statements
  
    # Returns true if the own class is equal to the other class and the
    # other object contains the same statements.
    #
    def ==(other)
      super && @statements == other.statements
    end
  
    # Returns a pretty print string containing the representations of
    # all substatements.
    #
    def to_s
      statements.collect { |s| s.to_s }.join(";\n")
    end
  
    # Executes all its substatements in a given context.
    #
    def interpret(context)
      statements.each { |s| s.interpret(context) }
    end

    # Compiles the composite statement to C code.
    #
    def compile_to_c
      statements.collect { |s| s.compile_to_c }.join("\n")
    end

    # Compiles the composite statment to Ruby code.
    #
    def compile_to_ruby
      statements.collect { |s| s.compile_to_ruby }.join("\n")
    end

    # Collects the names of all variables in the substatements.
    #
    def collect_variables
      variables = []
      statements.collect { |s| variables += s.collect_variables }
      variables.uniq
    end
  end
end
