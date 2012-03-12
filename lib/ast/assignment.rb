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

    # Compiles the assignment to C code.
    #
    def compile_to_c
      @variable.compile_to_c + " = " + @value.compile_to_c + ";"
    end

    # Compiles the assignment to Ruby code.
    #
    def compile_to_ruby
      @variable.compile_to_ruby + " = " + @value.compile_to_ruby
    end

    # Collects the names of the left variable and all variables in the right expression.
    #
    def collect_variables
      (@variable.collect_variables + @value.collect_variables).uniq
    end
  end
end
