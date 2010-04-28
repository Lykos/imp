require 'ast/arithmetic_expression'

module AST
  # Represents an IMP variable.
  #
  class Variable < ArithmeticExpression
    
    # Initializes a variable with a given name.
    #
    def initialize(name)
      @name = name
    end
  
    attr_reader :name
  
    # Returns true if the other object is also a variable and has the same name.
    #
    def ==(other)
      super && @name == other.name
    end
  
    # Returns a pretty print string of the variable.
    #
    def to_s
      @name
    end
  
    # Returns the value of the variable in a given context.
    #
    def interpret(context)
      context.get_variable(name)
    end

    # Compiles the variable to C code.
    #
    def compile_to_c
      @name
    end

    # Compiles the variable to Ruby code.
    #
    def compile_to_ruby
      @name
    end

    # Returns the name of the variable.
    #
    def collect_variables
      [@name]
    end
  end
end
