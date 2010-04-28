require 'forwardable'

require 'parser/syntax'
require 'parser/lexical_parser'
require 'parser/terminal_helper'

require 'ast/conditional'
require 'ast/assignment'
require 'ast/composite_statement'
require 'ast/skip'
require 'ast/while_loop'
require 'ast/local_variable_declaration'

require 'ast/less_than'
require 'ast/greater_than'
require 'ast/less_or_equal_than'
require 'ast/greater_or_equal_than'
require 'ast/equal_to'
require 'ast/unequal_to'

require 'ast/and'
require 'ast/not'
require 'ast/or'

require 'ast/plus'
require 'ast/minus'
require 'ast/times'

require 'ast/variable'
require 'ast/integer_constant'

module Parser
  # Represents a syntactic parser that is able to produce an abstract syntax tree of a given string. 
  #
  class SyntacticParser
  
    include Syntax
    include TerminalHelper
    extend Forwardable
  
    # Initializes the parser with a string and parse that string.
    #
    def initialize(program)
      @lexical_parser = LexicalParser.new(program)
      @ast = parse_statement
    end
  
    attr_reader :ast
  
    def_delegators :@lexical_parser, :next_token, :line_number, :look_ahead, :save_position, :restore_position
  
    # Decides if the statement continues.
    #
    def statement_continues?
      look_ahead =~ SEMICOLON
    end
  
    # Decides if the arithmetic expression continues.
    #
    def arithmetic_expression_continues?
      look_ahead =~ ARITHMETIC_OPERATOR
    end
  
    # Decides if the statement continues.
    #
    def boolean_expression_continues?
      look_ahead =~ BOOLEAN_OPERATOR
    end
  
    # Parses a composite statement that can contain multiple instructions.
    #
    def parse_statement
      statement = parse_simple_statement
      if statement_continues?
        statements = [statement]
        while statement_continues?
          parse_semicolon
          statements.push(parse_simple_statement)
        end
        statement = AST::CompositeStatement.new statements
      end
      statement
    end
  
    # Parses an else part if it is not existent, it is set to an else part with only a skip statement.
    #
    def parse_else_part
      t = look_ahead
      if t =~ ELSE_K
        parse_else
        parse_statement
      else
       AST:: Skip.new
      end
    end
  
    # Parses a single instruction.
    #
    def parse_simple_statement
      t = look_ahead
      if t =~ IF_K
        parse_if
        condition = parse_boolean_expression
        parse_then
        then_part = parse_statement
        else_part = parse_else_part
        parse_end
        AST::Conditional.new(condition, then_part, else_part)
      elsif t =~ WHILE_K
        parse_while
        condition = parse_boolean_expression
        parse_do
        body = parse_statement
        parse_end
        AST::WhileLoop.new(condition, body)
      elsif t =~ REPEAT
        parse_repeat
        body = parse_statement
        parse_until
        condition = parse_boolean_expression
        AST::CompositeStatement.new([body, AST::WhileLoop.new(AST::Not.new(condition), body)])
      elsif t =~ SKIP
        parse_skip
        AST::Skip.new
      elsif t =~ VAR
        parse_var
        variable = AST::Variable.new(parse_identifier)
        parse_assignment
        value = parse_arithmetic_expression
        parse_in
        body = parse_statement
        parse_end
        AST::LocalVariableDeclaration.new(variable, value, body)
      elsif t =~ IDENTIFIER
        variable = AST::Variable.new(parse_identifier)
        parse_assignment
        value = parse_arithmetic_expression
        AST::Assignment.new(variable, value)
      elsif t == nil
        raise "Another statement expected."
      else
        raise "Syntax error, #{t} makes no sense at this point."
      end
    end
  
    # Parses a composite boolean expression.
    #
    def parse_boolean_expression
      t = look_ahead
      if t =~ NOT_K
        parse_not
        expression = parse_boolean_expression
        AST::Not.new(expression)
      elsif t =~ PARENTHESE_OPEN
        # Problem: Parentheses could also stand for arithmetic expressions.
        # So one has to handle a nondeterministic choice here.
        # This is an ugly hack and terribly slow.
        position = save_position
        begin
          parse_parenthese_open
          left_expression = parse_boolean_expression
          operator = parse_binary_boolean_operator
          right_expression = parse_boolean_expression
          parse_parenthese_closed
          if operator =~ OR_K
            AST::Or.new(left_expression, right_expression)
          elsif operator =~ AND_K
            AST::And.new(left_expression, right_expression)
          else
            raise "Invalid boolean operator #{operator}."
          end
          # TODO: Introduce own exceptions.
        rescue RuntimeError
          restore_position(position)
          parse_comparation
        end
      else
        parse_comparation
      end
    end
  
  
    # Parses a single comparation.
    #
    def parse_comparation
      left_arithmetic_expression = parse_arithmetic_expression
      comparator = parse_binary_comparation_operator
      right_arithmetic_expression = parse_arithmetic_expression
      (pick_comparation_class(comparator)).new(left_arithmetic_expression, right_arithmetic_expression)
    end
  
    def pick_comparation_class(comparator)
      if comparator =~ LESS_OR_EQUAL_THAN
        AST::LessOrEqualThan
      elsif comparator =~ GREATER_OR_EQUAL_THAN
        AST::GreaterOrEqualThan
      elsif comparator =~ LESS_THAN
        AST::LessThan
      elsif comparator =~ GREATER_THAN
        AST::GreaterThan
      elsif comparator =~ EQUAL_TO
        AST::EqualTo
      elsif comparator =~ UNEQUAL_TO
        AST::UnequalTo
      else
        raise "Invalid binary comparation operator #{comparator}"
      end
    end
  
    # Parses a composite arithmetic expression.
    #
    def parse_arithmetic_expression
      t = look_ahead
      if t =~ PARENTHESE_OPEN
        parse_parenthese_open
        left_expression = parse_arithmetic_expression
        operator = parse_binary_arithmetic_operator
        right_expression = parse_arithmetic_expression
        parse_parenthese_closed
        if operator =~ PLUS
          AST::Plus.new(left_expression, right_expression)
        elsif operator =~ MINUS
          AST::Minus.new(left_expression, right_expression)
        elsif operator =~ TIMES
          AST::Times.new(left_expression, right_expression)
        else
          raise "Invalid arithmetic operator. #{operator}"
        end
      else
        parse_simple_arithmetic_expression
      end
    end
  
    # Parses an arithmetic terminal, that is a variable or an integer constant.
    #
    def parse_simple_arithmetic_expression
      t = look_ahead
      if t =~ IDENTIFIER
        AST::Variable.new(parse_identifier)
      elsif t =~ NUMERAL
        AST::IntegerConstant.new(parse_numeral)
      end
    end
  end
end
