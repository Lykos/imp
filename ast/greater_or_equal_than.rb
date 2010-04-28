require 'ast/comparation'

module AST
  # Represents a greater or equal than boolean expression in Ruby.
  #
  class GreaterOrEqualThan < Comparation
  
    # String representation of the operator.
    #
    def operator_string
      ">="
    end
  
    # Is the left operator greater or equal than the right one?
    #
    def evaluate_operator(left, right)
      left >= right
    end
  end
end
