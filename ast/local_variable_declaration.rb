require 'ast/statement'

module AST
  # Represents a local variable declaration in IMP.
  #
  class LocalVariableDeclaration < Statement
  
    # Initializes a local variable declaration with a variable, a value and a statement as its body.
    def initialize(variable, value, body)
      @variable = variable
      @value = value
      @body = body
    end
  
    attr_reader :variable, :value, :body
  
    # Returns true if the own class, variable, the value and the body are equal to the other objects corresponding values.
    #
    def ==(other)
      super && @variable == other.variable && @value == other.value && @body == other.body
    end
  
    # Returns a pretty print string of the local variable declaration.
    #
    def to_s
      "var " + @variable.to_s + " := " + @value.to_s + " in\n" + indent(@body.to_s) + "\nend"
    end
  
    # Sets the variable to the value, executes the body and restores the old value.
    #
    def interpret(context)
      old_value = context.get_variable(@variable.name)
      context.set_variable(@variable.name, @value.interpret(context))
      @body.interpret(context)
      context.set_variable(@variable.name, old_value)
    end

    # Compiles the local variable declaration to C code.
    #
    def compile_to_c
      raise "Compilation of local variable declarations to C code is not supported yet."
    end

    # Compiles the local variable declaration to Ruby code.
    #
    def compile_to_ruby
      raise "Compilation of local variable declarations to Ruby code is not supported yet."
    end
  end
end
