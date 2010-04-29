#!/usr/bin/env ruby

require 'test/unit'
require 'test/programs_helper'
require 'interpreter/interpreter'

class TestInterpreter < Test::Unit::TestCase
  include ProgramsHelper
  include Interpreter

  def test_if_false
    interpreter = Interpreter.new(PROGRAMS["if"])
    interpreter.set_variable("a", 0)
    interpreter.run
    assert_equal(0, interpreter.get_variable("a"), "The interpreter executed the then part with a false condition.")
  end

  def test_if_true
    interpreter = Interpreter.new(PROGRAMS["if"])
    interpreter.set_variable("a", 3)
    interpreter.run
    assert_equal(1, interpreter.get_variable("a"), "The interpreter didn't execute the then part with a true condition.")
  end

  def test_while_false
    interpreter = Interpreter.new(PROGRAMS["while"])
    interpreter.set_variable("a", 0)
    interpreter.run    
    assert_equal(0, interpreter.get_variable("a"), "The interpreter didn't overjump the while body with a false condition.")
  end

  def test_while_true
    interpreter = Interpreter.new(PROGRAMS["while"])
    interpreter.set_variable("a", 3)
    interpreter.run    
    assert_equal(1, interpreter.get_variable("a"), "The interpreter didn't execute the while body with a true condition often enough.")
  end

  def test_repeat_false
    interpreter = Interpreter.new(PROGRAMS["repeat"])
    interpreter.set_variable("a", 100)
    interpreter.run    
    assert_equal(101, interpreter.get_variable("a"), "The interpreter didn't execute the repeat body exactly once with a false condition.")
  end

  def test_repeat_true
    interpreter = Interpreter.new(PROGRAMS["repeat"])
    interpreter.set_variable("a", 3)
    interpreter.run    
    assert_equal(11, interpreter.get_variable("a"), "The interpreter didn't execute the repeat body with a true condition often enough.")
  end

  def test_assignment
    interpreter = Interpreter.new("a := (10 + 1)")
    interpreter.run    
    assert_equal(11, interpreter.get_variable("a"), "The interpreter didn't assign the value correctly.")
  end

  def test_composite
    interpreter = Interpreter.new(PROGRAMS["composite"])
    interpreter.run    
    assert_equal(2, interpreter.get_variable("a"), "The interpreter didn't assign the value 'a' correctly in a composite statement.")
    assert_equal(3, interpreter.get_variable("b"), "The interpreter didn't assign the value 'b' correctly in a composite statement.")
  end

  def test_boolean
    interpreter = Interpreter.new(PROGRAMS["boolean"])
    interpreter.set_variable("a", 1)
    # Caution, this could result in an infinite loop if it's incorrect...
    interpreter.run
    assert(true, "The interpreter didn't leave the while loop even though he should have.")
  end

  def test_arithmetic
    interpreter = Interpreter.new(PROGRAMS["arithmetic"])
    values = [
              [11, 23, 6],
              [0, 1, 2],
              [-4, 5, 89],
              [-12, 53, 21]
             ]

    10.times {values.push([rand(100) - 50, rand(100) - 50, rand(100) - 50])}
    values.length.times do |i|
      a, c, d = values[i]
      interpreter.set_variable("a", a)
      interpreter.set_variable("c", c)
      interpreter.set_variable("d", d)
      interpreter.run
      actual = ((2 * a) + (3 * (c - ((d + 1) - 1))))
      assert_equal(actual, interpreter.get_variable("a"), "The interpreter didn't calculate the complicated arithmetic expression correctly in round #{i+1}")
    end
  end
  
  def test_local
    interpreter = Interpreter.new(PROGRAMS["local"])
    interpreter.run
    assert_equal(2, interpreter.get_variable("a"), "The local variable declaration didn't work properly.")
  end

=begin
Not supported.

  def test_if_variable
    interpreter = Interpreter.new(PROGRAMS["if_variable"])
    interpreter.run
    assert_equal(6, interpreter.get_variable("if"), "The interpreter got it wrong with if as a variable.")
  end
=end
end
