require 'parser/syntactic_parser'

module Compiler
  # Represents an IMP to Ruby compiler.
  #
  class CCompiler

    MAIN_HEADER = "int main(void) {"
    MAIN_RETURN = "return 0;"
    MAIN_FOOTER = "}"

    def initialize(program)
      parser = Parser::SyntacticParser.new(program)
      @ast = parser.ast
    end

    attr_reader :output

    # Return the compiled Ruby output.
    #
    def compile
      variables = @ast.collect_variables.collect { |v| v + " = 0" }
      variable_declarations = @ast.indent_c("int " + variables.join(", ") + ";")
      main_statement = @ast.indent_c(@ast.compile_to_c) + "\n" + @ast.indent_c(MAIN_RETURN)
      @output = MAIN_HEADER + "\n" + variable_declarations + "\n" +
        main_statement + "\n" + MAIN_FOOTER + "\n"
    end
  end
end
