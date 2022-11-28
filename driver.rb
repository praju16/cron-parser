require "./lib/cron_expression_parser"

class Driver
  def input_handler
    return unless is_valid_input?(ARGV[0])

    cron_expression_algorithm = CronExpressionParser.new
    output_mapper = cron_expression_algorithm.parse(ARGV[0])

    output_format(output_mapper)
  end

  def is_valid_input?(arguments)
    return puts "No arguments passed" if arguments.nil?
    values = arguments.split(" ")
    if values.length == 6
      true
    else
      puts "Wrong number of parameters passed"
    end
  end

  def output_format(output_mapper)
    output_mapper.each do |key, value|
      puts "#{key.ljust(14)} #{value}"
    end
  end
end

driver = Driver.new
driver.input_handler
