require 'parser/syntax'

module Parser
  # Indentifies the tokens in a given string and does lexical parsing.
  #
  class LexicalParser
    
    include Syntax
  
    # Divides the given string into an array of tokens.
    #
    def initialize(program)
      @tokens = []
      @line_numbers = []
      line_no = 0
      program.each do |line|
        # TODO: Exception in case of invalid characters.
        line_no += 1
        new_tokens = line.scan(TOKEN)
        @tokens += new_tokens
        @line_numbers += [line_no] * new_tokens.length
      end
      @index = 0
    end
  
    # Returns next token and deletes the old.
    #
    def next_token
      @line_number
      t = @tokens[@index]
      @index += 1
      t
    end
  
    # Returns the current line number
    #
    def line_number
      @line_numbers[@index]
    end
  
    # Returns the next token without advancing to that token.
    #
    def look_ahead(number=1)
      @tokens[@index + number - 1]
    end
  
    # Returns the current position.
    # WARNING: Don't use the value for anything else than restore_position.
    # Maybe this won't stay an integer forever.
    #
    def save_position
      @index
    end
  
    # Retores a given position.
    #
    def restore_position(index)
      @index = index
    end
  end
end
