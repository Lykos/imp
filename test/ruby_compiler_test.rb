# usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__),'..','lib')
$:.unshift File.dirname(__FILE__)

require 'test/unit'
require 'programs_helper'
require 'compiler/ruby_compiler'

class RubyCompilerTest < Test::Unit::TestCase
  def test_foo
    #TODO: Write test
    flunk "TODO: Write test"
    # assert_equal("foo", bar)
  end
end
