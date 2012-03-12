require 'ast/comparation'

module AST
  # Represents a less or equal than boolean expression in Ruby.
  #
  class LessOrEqualThan < Comparation
  
    # String representation of the operator.
    #
    def operator_string
      "<="
    end
  
    # Is the left operator less or equal than the right one?
    #
    def evaluate_operator(left, right)
      left <= right
    end
  end
end
