require 'ast/comparation'

module AST
  # Represents a equal to boolean expression in Ruby.
  #
  class EqualTo < Comparation
  
    # String representation of the operator.
    #
    def operator_string
      "="
    end
  
    # Is the left operator equal to the right one?
    #
    def evaluate_operator(left, right)
      left == right
    end
  end
end
