require 'ast/statement'

# Represents an IMP conditional statement.
#
class Conditional < Statement

  # Initializes the conditional with a given condition, then_part and else_part
  #
  def initialize(condition, then_part, else_part)
    @condition = condition
    @then_part = then_part
    @else_part = else_part
  end

  attr_reader :condition, :then_part, :else_part

  # Returns true if the own class is equal to the other class and if the other object
  # contains the same condition, the same then part and the same else part.
  #
  def ==(other)
    super && @condition == other.condition && @then_part == other.then_part && @else_part == other.else_part
  end

  # Returns a pretty print string of the conditional.
  #
  def to_s
    "if " + @condition.to_s + " then\n" + indent(@then_part.to_s) + (else_part.skip? ? "" : ("\nelse\n" + indent(@else_part.to_s))) + "\nend"
  end

  # Executes the conditional in a given context.
  #
  def interpret(context)
    if @condition.interpret(context) then
      @then_part.interpret(context)
    else
      @else_part.interpret(context)
    end
  end
end
