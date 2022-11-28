require_relative "./fields/minute_field"
require_relative "./fields/hour_field"
require_relative "./fields/day_of_week_field"
require_relative "./fields/day_of_month_field"
require_relative "./fields/month_field"
require_relative "./fields/command_field"

module CronParseConfiguration
  ARGUMENT_INDEX_NAME_MAPPER = {
    0 => "minute",
    1 => "hour",
    2 => "dayofmonth",
    3 => "month",
    4 => "dayofweek",
    5 => "command"
  }

  ARGUMENT_INDEX_OBJECT_MAPPER = [
    MinuteField.new,
    HourField.new,
    DayOfMonthField.new,
    MonthField.new,
    DayOfWeekField.new,
    CommandField.new
  ].freeze

  ExpressionError = Class.new(StandardError)
end
