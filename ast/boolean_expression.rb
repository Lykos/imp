require 'ast/expression'

# Represents a boolean expression in IMP.
#
class BooleanExpression < Expression

  # Returns a new boolean expression that is the disjunction of the current and the other expression.
  #
  def |(other)
    return Or.new(self, other)
  end

  # Returns a new boolean expression that is the conjunction of the current and the other expression.
  #
  def &(other)
    return And.new(self, other)
  end
end
