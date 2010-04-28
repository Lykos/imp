require 'ast/arithmetic_expression'

# Represents an IMP integer constant.
#
class IntegerConstant < ArithmeticExpression

  # Initialize an integer constant with a given value.
  #
  def initialize(value)
    @value = value
  end

  # Returns true if the other object is also an integer constant and has the same value.
  #
  def ==(other)
    super && @value == other.value
  end
 
  # Returns a pretty print string of the integer constant.
  #
  def to_s
    @value.to_s
  end

  # Returns the value of the integer constant.
  #
  def interpret(context)
    @value
  end

  attr_reader :value
end
