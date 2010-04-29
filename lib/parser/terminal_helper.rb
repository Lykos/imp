require 'parser/syntax'

module Parser
  # Provides utilities to parse terminal expressions. Is based on next_token and look_ahead.
  #
  module TerminalHelper
  
    include Syntax
    
    # Parses an indentifier.
    #
    def parse_identifier
      raise "Reserved word #{look_ahead} used as a variable." if look_ahead =~ SPECIAL_WORD
      raise "Identifier expected. Got '#{look_ahead}'." unless look_ahead =~ IDENTIFIER
      next_token
    end
  
    # Parses a numeral.
    #
    def parse_numeral
      raise "Numeral expected. Got '#{look_ahead}'." unless look_ahead =~ NUMERAL
      next_token.to_i
    end
  
    # Parses any kind of terminal (or combination).
    #
    def method_missing(name, *args)
      string_name = name.to_s.gsub(":", "")
      super(name, *args) unless string_name =~ /^parse_/ and args.empty?
      token = string_name.to_s.gsub("parse_", "")
      constant = token.upcase
      constant += "_K" unless Syntax.const_defined?(constant)
      super(name) unless Syntax.const_defined?(constant)
      raise "'#{token}' expected. Got '#{look_ahead}'." unless look_ahead =~ Syntax.const_get(constant)
      next_token
    end
  end
end
