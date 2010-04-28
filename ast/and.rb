require 'ast/composite_boolean_expression'

# Represents a conjunction in IMP.
#
class And < CompositeBooleanExpression

  # String representation of the operator.
  #
  def operator_string
    "and"
  end

  # Conjuncts two given booleans.
  #
  def evaluate_operator(left, right)
    left and right
  end
end
