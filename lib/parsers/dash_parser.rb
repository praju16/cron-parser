class DashParser
  attr_reader :allowed_values

  def initialize(allowed_values)
    @allowed_values = allowed_values
  end

  def is_applicable?(expression)
    matched_values = expression.match("(.*)-(.*)")
    return false if matched_values.nil?
    values = matched_values[0].split("-")
    return false if (values[0] > values[1]) or  values.length > 2
    allowed_values.include?(values[0]) && allowed_values.include?(values[1])
  end

  def transform(expression)
    values = expression.split("-")
    start_index = allowed_values.find_index(values.first)
    end_index = allowed_values.find_index(values.last)
    allowed_values[start_index..end_index].join(" ")
  end
end
