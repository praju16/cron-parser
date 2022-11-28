require_relative "./field"
require_relative "../parsers/value_parser"

class CommandField < Field
  def initialize
    super
    @allowed_parsers.push(ValueParser.new(["ANY"]))
  end
end
