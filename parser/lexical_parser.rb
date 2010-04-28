require 'parser/syntax'

# Indentifies the tokens in a given string and does lexical parsing.
#
class LexicalParser
  
  include Syntax

  # Divides the given string into an array of tokens.
  #
  def initialize(program)
    @tokens = program.scan(TOKEN)
    @line_number = [0] * @tokens.length
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
    @line_number[@index]
  end

  # Returns the next token without advancing to that token.
  #
  def look_ahead
    @tokens[@index]
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
