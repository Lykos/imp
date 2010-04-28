require 'ast/expression'

module AST
  # Represents a arithmetic expression in IMP.
  #
  class ArithmeticExpression < Expression
  
    # Returns a new arithmetic expression that is an addition of the current and the other expression.
    #
    def +(other)
      return Plus.new(self, other)
    end
  
    # Returns a new arithmetic expression that is an subtraction of the current and the other expression.
    #
    def -(other)
      return Minus.new(self, other)
    end
  
    # Returns a new arithmetic expression that is an multiplication of the current and the other expression.
    #
    def *(other)
      return Times.new(self, other)
    end
  
=begin
I took those out because it seems odd if == and <= do not fit together and I need == in another context.
Furthermore, it seems very odd if they do not return a boolean value.

  # Retuns a new boolean expression that evaluates to true if the current object is less or equal than the other object.
  #
  def <=(other)
    return LessOrEqualThan.new(self, other)
  end

  # Retuns a new boolean expression that evaluates to true if the current object is greater or equal than the other object.
  #
  def >=(other)
    return GreaterOrEqualThan.new(self, other)
  end

  # Retuns a new boolean expression that evaluates to true if the current object is less than the other object.
  #
  def <(other)
    return LessThan.new(self, other)
  end

  # Retuns a new boolean expression that evaluates to true if the current object is greater than the other object.
  #
  def >(other)
    return GreaterThan.new(self, other)
  end
=end
  end
end
