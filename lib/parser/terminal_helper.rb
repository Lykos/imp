require 'parser/syntax'

module Parser
  # Provides utilities to parse terminal expressions. Is based on next_token and look_ahead.
  # TODO: Has become too small and too senseless to exist after the last refactoring session.
  # Maybe delete this class.
  #
  module TerminalHelper
  
    include Syntax
      
    # Parses any kind of terminal (or combination).
    #
    def method_missing(name, *args)
      string_name = name.to_s.gsub(":", "")
      super(name, *args) unless string_name =~ /^parse_/ and args.empty?
      token = string_name.to_s.gsub("parse_", "")
      constant = token.upcase
      constant += "_K" unless Syntax.const_defined?(constant)
      super(name) unless Syntax.const_defined?(constant)
      raise "Line #{line_number}: '#{token}' expected. Got '#{look_ahead}'." unless look_ahead =~ Syntax.const_get(constant)
      next_token
    end
  end
end
