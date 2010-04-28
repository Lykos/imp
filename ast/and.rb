require 'ast/composite_boolean_expression'

module AST
  # Represents a conjunction in IMP.
  #
  class And < CompositeBooleanExpression
    
    # String representation of the operator.
    #
    def operator_string
      "and"
    end

    # The C equivalent of 'and'.
    #
    def operator_c_string
      "&&"
    end
   
    # Conjuncts two given booleans.
    #
    def evaluate_operator(left, right)
      left and right
    end
  end
end
