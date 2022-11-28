class SlashParser
  attr_reader :allowed_values

  def initialize(allowed_values)
    @allowed_values = allowed_values
  end

  def is_applicable?(expression)
    matched_values = expression.match("(.*)/(.*)")
    return false if matched_values.nil?
    values =  matched_values[1..2]
    is_numeric_slash?(values) || is_asterisk_slash?(values) || is_range_slash?(values)
  end

  def transform(expression)
    sub_expressions = expression.split("/")
    increment = sub_expressions[1].to_i

    if is_numeric_slash?(sub_expressions)
      values = get_incremental_list(sub_expressions.first.to_i, allowed_values.last.to_i, increment)
    elsif is_asterisk_slash?(sub_expressions)
      values = get_incremental_list(0, allowed_values.last.to_i, increment)
    elsif is_range_slash?(sub_expressions)
      range_values = sub_expressions[0].split("-")
      values = get_incremental_list(range_values.first.to_i, range_values.last.to_i, increment)
    end
    values.join(" ")
  end

  private

  def get_incremental_list(start_value, end_value, increment)
    values = []
    while start_value <= end_value
      values.push(start_value)
      start_value += increment
    end
    values
  end

  def is_numeric_slash?(values)
    allowed_values.include?(values[0]) && allowed_values.include?(values[1])
  end

  def is_asterisk_slash?(values)
    "*".eql?(values[0]) && allowed_values.include?(values[1])
  end

  def is_range_slash?(values)
    return false unless values[0].include?("-")
    range_values = values[0].split("-") 
    return false if (range_values[0] > range_values[1]) or range_values.length > 2
    allowed_values.include?(range_values[0]) && allowed_values.include?(range_values[1])
  end
end
