class AsteriskParser
  attr_reader :allowed_values

  def initialize(allowed_values)
    @allowed_values = allowed_values
  end

  def is_applicable?(expression)
    "*".eql?(expression)
  end

  def transform(expression)
    allowed_values.join(" ")
  end
end
