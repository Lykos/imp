require 'ast/statement'

# Represents a composite statement that consits of many simple statements.
#
class CompositeStatement < Statement

  # Initializes a given composite statement with an array of statements.
  #
  def initialize(statements)
    @statements = statements
  end

  attr_reader :statements

  # Returns true if the own class is equal to the other class and the
  # other object contains the same statements.
  #
  def ==(other)
    super && @statements == other.statements
  end

  # Returns a pretty print string containing the representations of
  # all substatements.
  #
  def to_s
    statements.collect { |s| s.to_s }.join(";\n")
  end

  # Executes all its substatements in a given context.
  #
  def interpret(context)
    statements.each { |s| s.interpret(context) }
  end
end
