require 'ast/statement'

module AST
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

    # Compiles the skip statement to C code.
    #
    def compile_to_c
      ""
    end

    # Compiles the skip statement to Ruby code.
    #
    def compile_to_ruby
      ""
    end
  end
end
