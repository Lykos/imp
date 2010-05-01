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
  
    # Is the next token a special word? (keyword or skip etc)
    #
    def special_word?
      look_ahead =~ SPECIAL_WORD and not look_ahead(2) =~ ASSIGNMENT
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
      if look_ahead =~ ELSE_K
        parse_else
        parse_statement
      else
       AST:: Skip.new
      end
    end

    # Parses a special construct.
    #
    def parse_special
      if look_ahead =~ IF_K
        parse_if
        condition = parse_boolean_expression
        parse_then
        then_part = parse_statement
        else_part = parse_else_part
        parse_end
        AST::Conditional.new(condition, then_part, else_part)
      elsif look_ahead =~ WHILE_K
        parse_while
        condition = parse_boolean_expression
        parse_do
        body = parse_statement
        parse_end
        AST::WhileLoop.new(condition, body)
      elsif look_ahead =~ REPEAT
        parse_repeat
        body = parse_statement
        parse_until
        condition = parse_boolean_expression
        AST::CompositeStatement.new([body, AST::WhileLoop.new(AST::Not.new(condition), body)])
      elsif look_ahead =~ VAR
        parse_var
        variable = AST::Variable.new(parse_identifier)
        parse_assignment
        value = parse_arithmetic_expression
        parse_in
        body = parse_statement
        parse_end
        AST::LocalVariableDeclaration.new(variable, value, body)
      elsif look_ahead =~ FOR_K
        # TODO: Check side conditions!
        parse_for
        variable = AST::Variable.new(parse_identifier)
        parse_assignment
        initial = parse_arithmetic_expression
        parse_to
        exit = parse_arithmetic_expression
        parse_do
        body = parse_statement
        parse_end
        initial_assignment = AST::Assignment.new(variable, initial)
        exit_variable = AST::Variable.new("y")
        step = AST::Assignment.new(variable, variable + AST::IntegerConstant.new(1))
        loop_body = AST::CompositeStatement.new([body, step])
        loop_condition = AST::LessOrEqualThan.new(variable, exit_variable)
        loop = AST::WhileLoop.new(loop_condition, loop_body)
        local_scope = AST::LocalVariableDeclaration.new(exit_variable, exit, loop)
        AST::CompositeStatement.new([initial_assignment, local_scope])
      elsif look_ahead =~ SKIP
        parse_skip
        AST::Skip.new
      else
        raise "#{t} is no special word."
      end
    end

    # Parses a single instruction.
    #
    def parse_simple_statement
      if special_word?
        parse_special
      elsif look_ahead =~ IDENTIFIER
        variable = AST::Variable.new(parse_identifier)
        parse_assignment
        value = parse_arithmetic_expression
        AST::Assignment.new(variable, value)
      elsif look_ahead == nil
        raise "Another statement expected."
      else
        raise "Syntax error, #{t} makes no sense at this point."
      end
    end
  
    # Parses a composite boolean expression.
    #
    def parse_boolean_expression
      if look_ahead =~ NOT_K
        parse_not_expression
      elsif look_ahead =~ TRUE_K
        parse_true_expression
      elsif look_ahead =~ PARENTHESE_OPEN
        # Problem: Parentheses could also stand for arithmetic expressions.
        # So one has to handle a nondeterministic choice here.
        # This is an ugly hack and terribly slow.
        position = save_position
        begin
          parse_binary_boolean_expression
        rescue RuntimeError # TODO: Introduce own exceptions.
          restore_position(position)
          parse_comparation
        end
      else
        parse_comparation
      end
    end

    # Parses a true value.
    #
    def parse_true_expression
      parse_true
      AST::EqualTo.new(AST::IntegerConstant.new(1), AST::IntegerConstant.new(1))
    end

    # Parses a binary boolean expression.
    #
    def parse_binary_boolean_expression
      parse_parenthese_open
      left_expression = parse_boolean_expression
      operator = parse_binary_boolean_operator
      right_expression = parse_boolean_expression
      parse_parenthese_closed
      pick_boolean_operator_class(operator).new(left_expression, right_expression)
    end

    # Parses a negated expression.
    #
    def parse_not_expression
      parse_not
      expression = parse_boolean_expression
      AST::Not.new(expression)
    end

    # Picks the right class for a given boolean operator.
    #
    def pick_boolean_operator_class(operator)
      if operator =~ OR_K
        AST::Or
      elsif operator =~ AND_K
        AST::And
      else
        raise "Invalid boolean operator #{operator}."
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
      if look_ahead =~ PARENTHESE_OPEN
        parse_binary_arithmetic_expression
      else
        parse_simple_arithmetic_expression
      end
    end

    # Parses a binary arithmetic expression.
    #
    def parse_binary_arithmetic_expression
        parse_parenthese_open
        left_expression = parse_arithmetic_expression
        operator = parse_binary_arithmetic_operator
        right_expression = parse_arithmetic_expression
        parse_parenthese_closed
        pick_arithmetic_operator_class(operator).new(left_expression, right_expression)
    end

    # Picks the right class for an arithmetic operator.
    #
    def pick_arithmetic_operator_class(operator)
      if operator =~ PLUS
        AST::Plus
      elsif operator =~ MINUS
        AST::Minus
      elsif operator =~ TIMES
        AST::Times
      else
        raise "Invalid arithmetic operator. #{operator}"
      end
    end

    # Parses an arithmetic terminal, that is a variable or an integer constant.
    #
    def parse_simple_arithmetic_expression
      if look_ahead =~ IDENTIFIER
        AST::Variable.new(parse_identifier)
      elsif look_ahead =~ NUMERAL
        AST::IntegerConstant.new(parse_numeral.to_i)
      end
    end
  end
end
