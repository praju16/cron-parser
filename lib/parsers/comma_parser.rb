class CommaParser
  attr_reader :allowed_values

  def initialize(allowed_values)
    @allowed_values = allowed_values
  end

  def is_applicable?(expression)
    matched_values = expression.match("(.*),(.*)")
    return false if matched_values.nil?
    values = matched_values[0].split(",")
    allowed_values.include?(values[0]) && allowed_values.include?(values[1])
  end

  def transform(expression)
    values = expression.split(",")
    values.join(" ")
  end
end
