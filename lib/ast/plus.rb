require 'ast/composite_arithmetic_expression'

module AST
  # Represents a addition in IMP.
  #
  class Plus < CompositeArithmeticExpression
  
    # String representation of the operator.
    #
    def operator_string
      "+"
    end
  
    # Adds two given numbers.
    #
    def evaluate_operator(left, right)
      left + right
    end
  end
end
