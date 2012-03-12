require 'ast/boolean_expression'
require 'ast/unary_helper'

module AST
  # Represents a negation in IMP.
  #
  class Not < BooleanExpression
    include UnaryHelper
  
    # Returns a string representation of the operator.
    #
    def operator_string
      "not"
    end

    # The C equivalent of 'not'.
    #
    def operator_c_string
      "!"
    end
  
    # Negates a given boolean.
    #
    def evaluate_operator(sub_exp)
      not sub_exp
    end
  end
end
