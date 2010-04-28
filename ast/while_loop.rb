require 'ast/statement'

# Represents a while loop in IMP
#
class WhileLoop < Statement

  # Initializes a while loop with a condition and a body.
  #
  def initialize(condition, body)
    @condition = condition
    @body = body
  end

  attr_reader :condition, :body

  # Returns true if the own class is equal to the other class and if the other object
  # contains the same condition and the same body.
  #
  def ==(other)
    super && @condition == other.condition && @body == other.body
  end

  # Returns a pretty print string of the conditional.
  #
  def to_s
    "while " + @condition.to_s + " do\n" + indent(@body.to_s) + "\nend"
  end

  # Executes the conditional in a given context.
  #
  def interpret(context)
    while @condition.interpret(context)
      @body.interpret(context)
    end
  end
end
