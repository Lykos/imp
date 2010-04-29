module AST
  # Useful functionality for binary operations
  # Is based on operator_string and evaluate_operator
  #
  module BinaryHelper
  
    # Initializes a binary expression with a left and a right subexpression.
    #
    def initialize(left_exp, right_exp)
      @left_expression = left_exp
      @right_expression = right_exp
    end
  
    attr_reader :right_expression, :left_expression
  
    # Returns true if the own class is equal to the class of the compared value and both subexpressions are equal.
    #
    def ==(other)
      self.class == other.class && @right_expression == other.right_expression && @left_expression == other.left_expression
    end
  
    # Returns a pretty print string of the binary expression.
    #
    def to_s
      "(" + string_without_parentheses + ")"
    end
  
    # Returns the pretty print string of the binary expression without parentheses.
    def string_without_parentheses
      @left_expression.to_s + " " + operator_string + " " + @right_expression.to_s
    end
  
    # Interprets the binary expression in a given context.
    #
    def interpret(context)
      evaluate_operator(@left_expression.interpret(context), @right_expression.interpret(context))
    end

    # Compiles the binary expression to C code.
    #
    def compile_to_c
      "(" + @left_expression.compile_to_c + " " + operator_c_string + " " + @right_expression.compile_to_c + ")"
    end

    # Compiles the binary expression to Ruby code.
    #
    def compile_to_ruby
      "(" + @left_expression.compile_to_ruby + " " + operator_ruby_string + " " + @right_expression.compile_to_ruby + ")"
    end

    # Is by default just equal to the normal operator string.
    #
    def operator_c_string
      operator_string
    end

    # Is by default just equal to the normal operator string.
    #
    def operator_ruby_string
      operator_string
    end

    # Collects the names of all variables in the subexpressions.
    #
    def collect_variables
      (@left_expression.collect_variables + @right_expression.collect_variables).uniq
    end
  end
end
