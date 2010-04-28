# Represents the current context.
#
class Context
  # Initialize a new context.
  #
  def initialize
    @variables = Hash.new
    @variables.default = 0
  end

  # Returns the value of a variable with a given name.
  #
  def get_variable(name)
    @variables[name]
  end

  # Sets the value of a variable with a given name to a given value.
  #
  def set_variable(name, value)
    @variables[name] = value
  end

  # Returns a string that contains the current values of all variables.
  #
  def output_variables
    string = ""
    @variables.each { |name, value| string += "#{name} = #{value}\n" }
    string
  end
end
