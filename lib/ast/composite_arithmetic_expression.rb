require 'ast/arithmetic_expression'
require 'ast/binary_helper'

module AST
  # Represents a composite arithmetic expression in IMP.
  #
  class CompositeArithmeticExpression < ArithmeticExpression
    include BinaryHelper
  end
end
