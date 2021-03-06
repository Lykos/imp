#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__),'..','lib')
$:.unshift File.dirname(__FILE__)

require 'test/unit'
require 'parser/syntactic_parser'
require 'programs_helper'
require 'parser/lexical_error'
require 'parser/imp_syntax_error'

# Warning! This is no serious unit testing, only a few very simple tricks.

class SyntacticParserTest < Test::Unit::TestCase
  include ProgramsHelper
  include Parser
  include AST

  def test_if
    ast = Conditional.new(
                          GreaterThan.new(
                                          Variable.new("a"),
                                          IntegerConstant.new(2)
                                          ),
                          Assignment.new(
                                         Variable.new("a"),
                                         IntegerConstant.new(1)
                                         ),
                          Skip.new
                          )
    assert_equal(ast, SyntacticParser.new(PROGRAMS["if"]).ast, "The parser parsed a conditional wrong.")
    assert_equal(ast, SyntacticParser.new(PROGRAMS["if_sugar"]).ast, "The parser parsed a conditional with syntactic sugar wrong.")
    assert_equal(PROGRAMS["if"], ast.to_s, "The to_s method doesn't work properly for conditional statements.")
  end

  def test_while
    ast = WhileLoop.new(
                          GreaterOrEqualThan.new(
                                                 Variable.new("a"),
                                                 IntegerConstant.new(2)
                                                 ),
                          Assignment.new(
                                         Variable.new("a"),
                                         Variable.new("a") - IntegerConstant.new(1)
                                         )
                          )
    assert_equal(ast, SyntacticParser.new(PROGRAMS["while"]).ast, "The parser parsed a while loop wrong.")
    assert_equal(PROGRAMS["while"], ast.to_s, "The to_s method doesn't work properly for while loops.")
  end
  
  def test_repeat
    assignment = Assignment.new(
                                Variable.new("a"),
                                Variable.new("a") + IntegerConstant.new(1)
                                )
    ast = CompositeStatement.new([
                                  assignment,
                                  WhileLoop.new(
                                                Not.new(
                                                        GreaterThan.new(
                                                                        Variable.new("a"),
                                                                        IntegerConstant.new(10)
                                                                        )
                                                        ),
                                                assignment
                                                )
                                 ])
    assert_equal(ast, SyntacticParser.new(PROGRAMS["repeat"]).ast, "The parser parsed a repeat statement wrong.")
  end

  def test_skip
    program = "skip"
    ast = Skip.new
    assert_equal(ast, SyntacticParser.new(program).ast, "The parser parsed a skip statement wrong.")
    assert_equal(program, ast.to_s, "The to_s method doesn't work properly for skip statements.")
  end

  def test_assignment
    program = "a := 2"
    ast = Assignment.new(Variable.new("a"), IntegerConstant.new(2))
    assert_equal(ast, SyntacticParser.new(program).ast, "The parser parsed an assignment wrong.")
    assert_equal(program, ast.to_s, "The to_s method doesn't work properly for assignments.")
  end

  def test_composite
    ast = CompositeStatement.new([
                                 Assignment.new(
                                                Variable.new("a"),
                                                IntegerConstant.new(2)
                                                ),
                                 Conditional.new(
                                                 UnequalTo.new(
                                                               Variable.new("a"),
                                                               IntegerConstant.new(2)
                                                               ),
                                                 Skip.new,
                                                 Assignment.new(
                                                                Variable.new("b"),
                                                                IntegerConstant.new(3)
                                                                )
                                                 )
                                 ])
    assert_equal(ast, SyntacticParser.new(PROGRAMS["composite"]).ast, "The parser parsed a composite statement wrong.")
    assert_equal(PROGRAMS["composite"], ast.to_s, "The to_s method doesn't work properly for arithmetic expressions.")
  end

  def test_boolean
    ast = WhileLoop.new(
                        And.new(
                                GreaterOrEqualThan.new(Variable.new("a"), IntegerConstant.new(2)),
                                Not.new(
                                        Or.new(
                                               LessOrEqualThan.new(
                                                                   Variable.new("b") + (IntegerConstant.new(14) - IntegerConstant.new(3)),
                                                                   Variable.new("c")
                                                                   ),
                                               EqualTo.new(
                                                           Variable.new("c"),
                                                           Variable.new("b")
                                                           )
                                               )
                                        )
                                ),
                        Assignment.new(
                                       Variable.new("d"),
                                       IntegerConstant.new(1)
                                       )
                        )
    assert_equal(ast, SyntacticParser.new(PROGRAMS["boolean"]).ast, "The parser parsed a statement with a complicated boolean expression wrong.")
    assert_equal(PROGRAMS["boolean"], ast.to_s, "The to_s method doesn't work properly for boolean expressions.")
  end

  def test_arithmetic
    ast = Assignment.new(
                         Variable.new("a"),
                         (IntegerConstant.new(2) * Variable.new("a")) +
                         (IntegerConstant.new(3) * (Variable.new("c") - ((Variable.new("d") + IntegerConstant.new(1)) - IntegerConstant.new(1))))
                         )
    assert_equal(ast, SyntacticParser.new(PROGRAMS["arithmetic"]).ast, "The parser parsed a statement with a complicated arithmetic expression wrong.")    
    assert_equal(PROGRAMS["arithmetic"], ast.to_s, "The to_s method doesn't work properly for arithmetic expressions.")
  end

  def test_nil
    program = ""
    assert_raise(IMPSyntaxError, "The parser didn't reject an empty input.") {SyntacticParser.new(program)}
  end

  def test_invalid
    program = "a >;"
    assert_raise(IMPSyntaxError, "The parser didn't reject an invalid input.") {SyntacticParser.new(program)}
  end

  def test_invalid_y_free
    program = "for x := 1 to n do y := 2 end"
    assert_raise(SideConditionError, "The parser didn't notice that 'y' was a free variable in the for body.") {SyntacticParser.new(program)}
  end

  def test_invalid_x_free
    program = "for x := 1 to x do z := 2 end"
    assert_raise(SideConditionError, "The parser didn't notice that 'x' was a free variable in the for final expression.") {SyntacticParser.new(program)}
  end

  def test_invalid_lexical
    program = "if !a=b then %a:=2 end"
    assert_raise(LexicalError, "The lexical parser didn't notice that the program contains illegal characters.") {SyntacticParser.new(program)}
  end

  def test_true
    program = "if true then skip end"
    ast = Conditional.new(
                          EqualTo.new(IntegerConstant.new(1), IntegerConstant.new(1)),
                          Skip.new,
                          Skip.new
                          )
    assert_equal(ast, SyntacticParser.new(program).ast, "The parser parsed something with true false.")
  end

  def test_for
    while_loop = WhileLoop.new(
                               LessOrEqualThan.new(
                                                   Variable.new("a"),
                                                   Variable.new("y")
                                                   ),
                               CompositeStatement.new([
                                                       Assignment.new(
                                                                      Variable.new("r"),
                                                                      Variable.new("r") + IntegerConstant.new(1)
                                                                      ),
                                                       Assignment.new(
                                                                      Variable.new("a"),
                                                                      Variable.new("a") + IntegerConstant.new(1)
                                                                      )
                                                       ])
                               )

    ast = CompositeStatement.new([
                                 Assignment.new(Variable.new("a"), IntegerConstant.new(5) + IntegerConstant.new(2)),
                                 LocalVariableDeclaration.new(
                                                              Variable.new("y"),
                                                              IntegerConstant.new(4) * IntegerConstant.new(3),
                                                              while_loop
                                                              )
                                 ])
    assert_equal(ast, SyntacticParser.new(PROGRAMS["for"]).ast, "The parser parsed the for loop false.")
  end

  def test_local
    ast = CompositeStatement.new([
                                 Assignment.new(
                                                Variable.new("a"),
                                                IntegerConstant.new(2)
                                                ),
                                 LocalVariableDeclaration.new(
                                                              Variable.new("a"),
                                                              IntegerConstant.new(3),
                                                              Assignment.new(
                                                                             Variable.new("a"),
                                                                             IntegerConstant.new(4)
                                                                             )
                                                              )
                                ])
    assert_equal(ast, SyntacticParser.new(PROGRAMS["local"]).ast, "The parser parsed a local variable declaration wrong.")
    assert_equal(PROGRAMS["local"], ast.to_s, "The to_s method doesn't work properly for local variable declarations.")
  end

  def test_if_variable
    ast = CompositeStatement.new([
                                 Assignment.new(
                                                Variable.new("if"),
                                                IntegerConstant.new(3)
                                                ),
                                  Conditional.new(
                                                  LessOrEqualThan.new(
                                                                      Variable.new("if"),
                                                                      IntegerConstant.new(2)
                                                                      ),
                                                  Assignment.new(
                                                                 Variable.new("if"),
                                                                 IntegerConstant.new(2)
                                                                 ),
                                                  Assignment.new(
                                                                 Variable.new("if"),
                                                                 Variable.new("if") + IntegerConstant.new(3)
                                                                 )
                                                  )
                                ])
    assert_equal(ast, SyntacticParser.new(PROGRAMS["if_variable"]).ast, "The parser parsed a program with if as a variable wrong.")
  end
end
