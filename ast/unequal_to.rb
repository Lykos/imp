require 'ast/comparation'

module AST
  # Represents an unequal to boolean expression in Ruby.
  #
  class UnequalTo < Comparation
  
    # String representation of the operator.
    #
    def operator_string
      "#"
    end
  
    # Is the left operator unequal to the right one?
    #
    def evaluate_operator(left, right)
      left != right
    end
  end
end
