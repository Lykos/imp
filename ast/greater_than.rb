require 'ast/comparation'

# Represents a greater than boolean expression in Ruby.
#
class GreaterThan < Comparation

  # String representation of the operator.
  #
  def operator_string
    ">"
  end

  # Is the left operator greater than the right one?
  #
  def evaluate_operator(left, right)
    left > right
  end
end
