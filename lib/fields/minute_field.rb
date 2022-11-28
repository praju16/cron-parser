require_relative "../parsers/asterisk_parser"
require_relative "../parsers/comma_parser"
require_relative "../parsers/dash_parser"
require_relative "../parsers/slash_parser"
require_relative "../parsers/value_parser"
require_relative "./field"

class MinuteField < Field
  def initialize
    super
    allowed_values = get_allowed_values
    @allowed_parsers.push(CommaParser.new(allowed_values))
    @allowed_parsers.push(DashParser.new(allowed_values))
    @allowed_parsers.push(AsteriskParser.new(allowed_values))
    @allowed_parsers.push(ValueParser.new(allowed_values))
    @allowed_parsers.push(SlashParser.new(allowed_values))
  end

  private

  def get_allowed_values
    (0..59).to_a.map(&:to_s)
  end
end
