require 'ast/comparation'

module AST
  # Represents a less than boolean expression in Ruby.
  #
  class LessThan < Comparation
  
    # String representation of the operator.
    #
    def operator_string
      "<"
    end
  
    # Is the left operator less than the right one?
    #
    def evaluate_operator(left, right)
      left < right
    end
  end
end
