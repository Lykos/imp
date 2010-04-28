require 'ast/composite_arithmetic_expression'

module AST
  # Represents a subtraction in IMP.
  #
  class Minus < CompositeArithmeticExpression
  
    # String representation of the operator.
    #
    def operator_string
      "-"
    end
  
    # Subtracts two given numbers.
    #
    def evaluate_operator(left, right)
      left - right
    end
  end
end
