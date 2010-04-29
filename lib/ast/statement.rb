require 'ast/syntactic_unit'

module AST
  # Represents a statement of the IMP language.
  #
  class Statement < SyntacticUnit
  
    IMP_INDENTATION = "  "
    C_INDENTATION = "\t"
    RUBY_INDENTATION = "  "
  
    # Is the current statment a skip statement?
    #
    def skip?
      false
    end
  
    # Indentates a given string for the imp language.
    #
    def indent(string)
      string.collect { |s| IMP_INDENTATION + s }.join
    end

    # Indentates a given string for the imp language.
    #
    def indent_c(string)
      string.collect { |s| C_INDENTATION + s }.join
    end

    # Indentates a given string for the imp language.
    #
    def indent_ruby(string)
      string.collect { |s| RUBY_INDENTATION + s }.join
    end
  end
end
