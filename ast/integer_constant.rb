require 'ast/arithmetic_expression'

module AST
  # Represents an IMP integer constant.
  #
  class IntegerConstant < ArithmeticExpression
  
    # Initialize an integer constant with a given value.
    #
    def initialize(value)
      @value = value
    end

    attr_reader :value
  
    # Returns true if the other object is also an integer constant and has the same value.
    #
    def ==(other)
      super && @value == other.value
    end
   
    # Returns a pretty print string of the integer constant.
    #
    def to_s
      @value.to_s
    end
  
    # Returns the value of the integer constant.
    #
    def interpret(context)
      @value
    end

    # Compiles the integer constant to C code.
    #
    def compile_to_c
      @value.to_s
    end

    # Compiles the integer constant to Ruby code.
    #
    def compile_to_ruby
      @value.to_s
    end
  end
end
