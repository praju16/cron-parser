class ValueParser
  attr_reader :allowed_values

  def initialize(allowed_values)
    @allowed_values = allowed_values
  end

  def is_applicable?(expression)
    allowed_values.include?(expression) || allowed_values.include?("ANY")
  end

  def transform(expression)
    expression
  end
end
