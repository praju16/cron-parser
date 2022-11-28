class CommaParser
  attr_reader :allowed_values

  def initialize(allowed_values)
    @allowed_values = allowed_values
  end

  def is_applicable?(expression)
    matched_values = expression.match("(.*),(.*)")
    return false if matched_values.nil?
    values = matched_values[0].split(",")
    values.all? { |value| allowed_values.include?(value) }
  end

  def transform(expression)
    values = expression.split(",")
    values.uniq.join(" ")
  end
end
