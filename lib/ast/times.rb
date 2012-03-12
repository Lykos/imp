require 'ast/composite_arithmetic_expression'

module AST
  # Represents a mulitplication in IMP.
  #
  class Times < CompositeArithmeticExpression
  
    # String representation of the operator.
    #
    def operator_string
      "*"
    end
  
    # Multiplies two given numbers.
    #
    def evaluate_operator(left, right)
      left * right
    end
  end
end
