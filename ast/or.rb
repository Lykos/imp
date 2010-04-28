require 'ast/composite_boolean_expression'

module AST
  # Represents a disjunction in IMP.
  #
  class Or < CompositeBooleanExpression
    
    # String representation of the operator.
    #
    def operator_string
      "or"
    end

    # The C equivalent of 'or'.
    #
    def operator_c_string
      "||"
    end
    
    # Disjuncts two given booleans.
    #
    def evaluate_operator(left, right)
      left or right
    end
  end
end
