module AST
  # Useful functionality for unary operations
  # Is based on operator_string and evaluate_operator
  #
  module UnaryHelper
    # Initializes a unary expression with a subexpression.
    #
    def initialize(exp)
      @expression = exp
    end
  
    attr_reader :expression
  
    # Returns true if the own class is equal to the class of the compared value and the subexpressions are equal.
    #
    def ==(other)
      self.class == other.class && @expression == other.expression
    end
  
    # Returns a pretty print string of the unary expression.
    #
    def to_s
      operator_string + " " + @expression.to_s
    end
  
    # Interprets the unary expression in a given context.
    #
    def interpret(context)
      evaluate_operator(@expression.interpret(context))
    end

    # Compiles the unary expression to C code.
    #
    def compile_to_c
      operator_c_string + "(" + @expression.compile_to_c + ")"
    end

    # Compiles the unary expression to Ruby code.
    #
    def compile_to_ruby
      operator_ruby_string + "(" + @expression.compile_to_ruby + ")"
    end

    # Is by default just equal to the normal operator string plus a whitespace.
    #
    def operator_c_string
      operator_string + " "
    end

    # Is by default just equal to the normal operator string a whitespace.
    #
    def operator_ruby_string
      operator_string + " "
    end
  end
end
