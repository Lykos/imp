require 'ast/arithmetic_expression'

# Represents an IMP variable.
#
class Variable < ArithmeticExpression
  
  # Initializes a variable with a given name.
  #
  def initialize(name)
    @name = name
  end

  attr_reader :name

  # Returns true if the other object is also a variable and has the same name.
  #
  def ==(other)
    super && @name == other.name
  end

  # Returns a pretty print string of the variable.
  #
  def to_s
    @name
  end

  # Returns the value of the variable in a given context.
  #
  def interpret(context)
    context.get_variable(name)
  end
end
