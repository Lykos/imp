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
  end
end
