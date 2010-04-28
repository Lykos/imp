require 'parser/syntax'

module Parser
  # Provides utilities to parse terminal expressions. Is based on next_token and look_ahead.
  #
  module TerminalHelper
  
    include Syntax
  
    # Parses a 'if'.
    #
    def parse_if
      raise "'if' expected. Got '#{look_ahead}'." unless look_ahead =~ IF_K
      next_token
    end
  
    # Parses a 'while'.
    #
    def parse_while
      raise "'while' expected. Got '#{look_ahead}'." unless look_ahead =~ WHILE_K
      next_token
    end
  
    # Parses a 'var'.
    #
    def parse_var
      raise "'var' expected. Got '#{look_ahead}'." unless look_ahead =~ VAR
      next_token
    end
  
    # Parses a 'repeat'.
    #
    def parse_repeat
      raise "'repeat' expected. Got '#{look_ahead}'." unless look_ahead =~ REPEAT
      next_token
    end
  
    # Parses a 'then'.
    #
    def parse_then
      raise "'then' expected. Got '#{look_ahead}'." unless look_ahead =~ THEN_K
      next_token
    end
  
    # Parses a 'do'.
    #
    def parse_do
      raise "'do' expected. Got '#{look_ahead}'." unless look_ahead =~ DO_K
      next_token
    end
  
    # Parses a 'else'.
    #
    def parse_else
      raise "'else' expected. Got '#{look_ahead}'." unless look_ahead =~ ELSE_K
      next_token
    end
  
    # Parses a 'until'.
    #
    def parse_until
      raise "'until' expected. Got '#{look_ahead}'." unless look_ahead =~ UNTIL_K
      next_token
    end
  
    # Parses a 'end'.
    #
    def parse_end
      raise "'end' expected. Got '#{look_ahead}'." unless look_ahead =~ END_K
      next_token
    end
  
    # Parses a 'in'.
    #
    def parse_in
      raise "'in' expected. Got '#{look_ahead}'." unless look_ahead =~ IN_K
      next_token
    end
  
    # Parses a 'skip'.
    #
    def parse_skip
      raise "'skip' expected. Got '#{look_ahead}'." unless look_ahead =~ SKIP
      next_token
    end
  
    # Parses a '('
    #
    def parse_parenthese_open
      raise "'(' expected. Got '#{look_ahead}'." unless look_ahead =~ PARENTHESE_OPEN
      next_token
    end
  
    # Parses a ')'
    #
    def parse_parenthese_closed
      raise "')' expected. Got '#{look_ahead}'." unless look_ahead =~ PARENTHESE_CLOSED
      next_token
    end
  
    # Parses a ':='
    #
    def parse_assignment
      raise "':=' expected. Got '#{look_ahead}'." unless look_ahead =~ ASSIGNMENT
      next_token
    end
  
    # Parses a ';'
    #
    def parse_semicolon
      raise "';' expected. Got '#{look_ahead}'." unless look_ahead =~ SEMICOLON
      next_token
    end
  
    # Parses a 'or' or a 'and'.
    #
    def parse_binary_boolean_operator
      raise "Binary boolean operator expected. Got '#{look_ahead}'." unless look_ahead =~ BINARY_BOOLEAN_OPERATOR
      next_token
    end
  
    # Parses a '+', a '-' or a '*'.
    #
    def parse_binary_arithmetic_operator
      raise "Binary arithmetic operator expected. Got '#{look_ahead}'." unless look_ahead =~ BINARY_ARITHMETIC_OPERATOR
      next_token
    end
  
    # Parses a '<', a '>', a '>=', a '<=', a '=' or a '#'.
    #
    def parse_binary_comparation_operator
      raise "Binary comparation operator expected. Got '#{look_ahead}'." unless look_ahead =~ BINARY_COMPARATION_OPERATOR
      next_token
    end
  
    # Parses an indentifier.
    #
    def parse_identifier
      raise "Reserved word #{t} used as a variable." if look_ahead =~ SPECIAL_WORD
      raise "Identifier expected. Got '#{look_ahead}'." unless look_ahead =~ IDENTIFIER
      next_token
    end
  
    # Parses a numeral.
    #
    def parse_numeral
      raise "Numeral expected. Got '#{look_ahead}'." unless look_ahead =~ NUMERAL
      next_token.to_i
    end
  
    # Parses a 'not'.
    #
    def parse_not
      raise "'not' expected. Got '#{look_ahead}'." unless look_ahead =~ NOT_K
      next_token
    end
  end
end
