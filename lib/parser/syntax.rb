require 'eregex'

module Parser
  # Sets up a few constants that describe the syntax.
  #
  module Syntax
    # _K stands for keyword and is necessary because else it would be a ruby keyword.
  
    LESS_OR_EQUAL_THAN = /<=/
    GREATER_OR_EQUAL_THAN = />=/
    LESS_THAN = /</
    GREATER_THAN = />/
    EQUAL_TO = /=/
    UNEQUAL_TO = /#/
    BINARY_COMPARATION_OPERATOR = Regexp.union( LESS_OR_EQUAL_THAN,
      GREATER_OR_EQUAL_THAN, LESS_THAN, GREATER_THAN, EQUAL_TO,
      UNEQUAL_TO )
  
    OR_K = /or/
    AND_K = /and/
    BINARY_BOOLEAN_OPERATOR = Regexp.union( OR_K, AND_K )
  
    NOT_K = /not/
  
    PLUS = /\+/
    MINUS = /-/
    TIMES = /\*/
    BINARY_ARITHMETIC_OPERATOR = Regexp.union( PLUS, MINUS, TIMES )
  
    PARENTHESE_OPEN = /\(/
    PARENTHESE_CLOSED = /\)/
    PARENTHESE = Regexp.union( PARENTHESE_OPEN, PARENTHESE_CLOSED )
  
    ASSIGNMENT = /:=/
  
    SEMICOLON = /;/
  
    SKIP = /skip/
  
    IF_K = /if/
    THEN_K = /then/
    ELSE_K = /else/
    END_K = /end/
    WHILE_K = /while/
    DO_K = /do/
    REPEAT = /repeat/
    UNTIL_K = /until/
    VAR = /var/
    IN_K = /in/
    KEYWORD = Regexp.union( IF_K, THEN_K, ELSE_K, END_K, WHILE_K, DO_K, REPEAT, UNTIL_K, VAR, IN_K )
  
    SPECIAL_WORD = Regexp.union( KEYWORD, SKIP )
  
    NUMERAL = /\d+/
  
    IDENTIFIER = /[A-Za-z]+/
  
    TOKEN = Regexp.union( BINARY_COMPARATION_OPERATOR, BINARY_BOOLEAN_OPERATOR,
      BINARY_ARITHMETIC_OPERATOR, NOT_K, PARENTHESE, ASSIGNMENT,
      SEMICOLON, SKIP, NUMERAL, IDENTIFIER, KEYWORD )
  end
end
