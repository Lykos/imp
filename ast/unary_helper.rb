# Useful functionality for unary operations
# Is based on operator_string and evaluate_operator
#
module UnaryHelper
  # Initializes a unary expression with a subexpression.
  #
  def initialize(exp)
    @expression = exp
  end

  attr_reader :expression

  # Returns true if the own class is equal to the class of the compared value and the subexpressions are equal.
  #
  def ==(other)
    self.class == other.class && @expression == other.expression
  end

  # Returns a pretty print string of the unary expression.
  #
  def to_s
    operator_string + " " + @expression.to_s
  end

  # Interprets the unary expression in a given context.
  #
  def interpret(context)
    evaluate_operator(@expression.interpret(context))
  end
end
