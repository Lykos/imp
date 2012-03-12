require 'ast/boolean_expression'
require 'ast/binary_helper'

module AST
  # Represents a composite boolean expression in IMP.
  #
  class CompositeBooleanExpression < BooleanExpression
    include BinaryHelper
  end
end
