require 'ast/statement'

module AST
  # Represents an assignment
  #
  class Assignment < Statement
    # Initialize the assignment with a variable and a value.
    #
    def initialize(variable, value)
      @variable = variable
      @value = value
    end
  
    attr_reader :variable, :value
  
    # Returns true if the own class equal to the class of the other object
    # and their variables and values are equal.
    #
    def ==(other)
      super && @variable == other.variable && @value == other.value
    end
    
    # Returns a pretty print string of the assignment.
    #
    def to_s
      @variable.to_s + " := " + @value.to_s
    end
  
    # Sets the variable in the context to the evuated value of the right expression.
    #
    def interpret(context)
      context.set_variable(@variable.name, @value.interpret(context))
    end
  end
end
