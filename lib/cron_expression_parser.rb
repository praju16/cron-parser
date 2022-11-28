require_relative "./cron_parse_configuration"

class CronExpressionParser
  include CronParseConfiguration

  def parse(expression)
    sub_expressions = expression.split(" ")

    input_mapper = {}
    sub_expressions.each_with_index do |sub_expression, index|
      input_key = ARGUMENT_INDEX_NAME_MAPPER[index]
      field_obj = ARGUMENT_INDEX_OBJECT_MAPPER[index]

      is_valid_field = false

      allowed_parsers = field_obj.get_allowed_parsers
      allowed_parsers.each do |parser|
        if parser.is_applicable?(sub_expression)
          is_valid_field = true
          values = parser.transform(sub_expression)
          input_mapper[input_key] = values
        end
      end
      fail ExpressionError, "Cant parse expression because expression value: #{sub_expression} is Invalid" unless is_valid_field
    end
    # puts input_mapper
    input_mapper
  end
end
