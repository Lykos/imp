require 'ast/syntactic_unit'

# Represents a statement of the IMP language.
#
class Statement < SyntacticUnit

  INDENTATION = "  "

  # Is the current statment a skip statement?
  #
  def skip?
    false
  end

  # Indentates a given string.
  #
  def indent(string)
    string.collect { |s| INDENTATION + s }.join
  end
end
