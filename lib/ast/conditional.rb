require 'ast/statement'

module AST
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

    # Compiles the conditional to C code.
    #
    def compile_to_c
      "if (" + @condition.compile_to_c + ") {\n" +
        indent_c(@then_part.compile_to_c) +
        "\n} else {\n" +
        indent_c(@else_part.compile_to_c) +
        "\n}"
    end

    # Compiles the conditional to Ruby code.
    #
    def compile_to_ruby
      "if " + indent_c(@condition.compile_to_ruby) + "\n" +
        indent_ruby(@then_part.compile_to_ruby) +
        "\nelse\n" +
        indent_c(@else_part.compile_to_ruby) +
        "\nend"
    end

    # Collects the names of all variables in the conditional, the then part and
    # the else_part.
    #
    def collect_variables
      (@condition.collect_variables + @then_part.collect_variables +
        @else_part.collect_variables).uniq
    end
  end
end
