# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')
$:.unshift File.dirname(__FILE__)

require 'test/unit'
require 'programs_helper'
require 'compiler/c_compiler'

class CCompilerTest < Test::Unit::TestCase
  include ProgramsHelper

  def test_collect_variables_arithmetic
    expected_variables = %w(a c d)
    actual_variables = Parser::SyntacticParser.new(PROGRAMS["arithmetic"]).ast.collect_variables
    assert_equal(expected_variables.sort, actual_variables.sort,
      "The AST collected the wrong variables in 'arithmetic.imp'.")
  end

  def test_collect_variables_boolean
    expected_variables = %w(a b c d)
    actual_variables = Parser::SyntacticParser.new(PROGRAMS["boolean"]).ast.collect_variables
    assert_equal(expected_variables.sort, actual_variables.sort,
      "The AST collected the wrong variables in 'boolean.imp'.")
  end

  def test_collect_variables_composite
    expected_variables = %w(a b)
    actual_variables = Parser::SyntacticParser.new(PROGRAMS["composite"]).ast.collect_variables
    assert_equal(expected_variables.sort, actual_variables.sort,
      "The AST collected the wrong variables in 'composite.imp'.")
  end

  def test_collect_variables_if
    expected_variables = %w(a)
    actual_variables = Parser::SyntacticParser.new(PROGRAMS["if"]).ast.collect_variables
    assert_equal(expected_variables.sort, actual_variables.sort,
      "The AST collected the wrong variables in 'if.imp'.")
  end

  def test_collect_variables_if_sugar
    expected_variables = %w(a)
    actual_variables = Parser::SyntacticParser.new(PROGRAMS["if_sugar"]).ast.collect_variables
    assert_equal(expected_variables.sort, actual_variables.sort,
      "The AST collected the wrong variables in 'if_sugar.imp'.")
  end

  def test_collect_variables_local
    expected_variables = %w(a)
    actual_variables = Parser::SyntacticParser.new(PROGRAMS["local"]).ast.collect_variables
    assert_equal(expected_variables.sort, actual_variables.sort,
      "The AST collected the wrong variables in 'local.imp'.")
  end

  def test_collect_variables_local2
    expected_variables = %w()
    actual_variables = Parser::SyntacticParser.new(PROGRAMS["local2"]).ast.collect_variables
    assert_equal(expected_variables.sort, actual_variables.sort,
      "The AST collected the wrong variables in 'local2.imp'.")
  end

  def test_collect_variables_repeat
    expected_variables = %w(a)
    actual_variables = Parser::SyntacticParser.new(PROGRAMS["repeat"]).ast.collect_variables
    assert_equal(expected_variables.sort, actual_variables.sort,
      "The AST collected the wrong variables in 'repeat.imp'.")
  end

  def test_collect_variables_root
    expected_variables = %w(z v i x y)
    actual_variables = Parser::SyntacticParser.new(PROGRAMS["root"]).ast.collect_variables
    assert_equal(expected_variables.sort, actual_variables.sort,
      "The AST collected the wrong variables in 'root.imp'.")
  end

  def test_collect_variables_while
    expected_variables = %w(a)
    actual_variables = Parser::SyntacticParser.new(PROGRAMS["while"]).ast.collect_variables
    assert_equal(expected_variables.sort, actual_variables.sort,
      "The AST collected the wrong variables in 'while.imp'.")
  end
end
