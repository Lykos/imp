require 'ast/boolean_expression'
require 'ast/binary_helper'

# Represents a composite boolean expression in IMP.
#
class CompositeBooleanExpression < BooleanExpression
  include BinaryHelper
end
