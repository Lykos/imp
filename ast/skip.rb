require 'ast/statement'

# Represents a skip statement that does nothing.
#
class Skip < Statement

  # Is the current statement a skip statement?
  #
  def skip
    true
  end

  # Returns a pretty print string of the skip statement.
  #
  def to_s
    "skip"
  end

  # Do nothing.
  #
  def interpret(context)
  end
end
