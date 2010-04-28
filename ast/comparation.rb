require 'ast/boolean_expression'
require 'ast/binary_helper'

# Represents a comparation of two arithmetic expressions in IMP.
#
class Comparation < BooleanExpression
  include BinaryHelper

  # Returns a pretty print string of the comparation.
  #
  def to_s
    string_without_parentheses
  end
end
