require_relative "../lib/cron_expression_parser"
require_relative "../lib/cron_parse_configuration"

RSpec.describe CronExpressionParser do
  before :all do
    @cron_expression_algorithm = CronExpressionParser.new
  end

  context "When expression is valid:" do
    it "when expression is example input '*/15 0 1,15 * 1-5 /usr/bin/find' " do
      expected_val = {"minute" => "0 15 30 45", "hour" => "0", "dayofmonth" => "1 15", "month" => "1 2 3 4 5 6 7 8 9 10 11 12", "dayofweek" => "1 2 3 4 5", "command" => "/usr/bin/find"}
      response = @cron_expression_algorithm.parse("*/15 0 1,15 * 1-5 /usr/bin/find")
      expect(response).to eq expected_val
    end

    it "when expression is all expression '* * * * * /usr/bin/find' " do
      expected_val = {"minute" => "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59", "hour" => "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23", "dayofmonth" => "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31", "month" => "1 2 3 4 5 6 7 8 9 10 11 12", "dayofweek" => "0 1 2 3 4 5 6", "command" => "/usr/bin/find"}
      response = @cron_expression_algorithm.parse("* * * * * /usr/bin/find")
      expect(response).to eq expected_val
    end

    it "when expression is comma expression '2,11,45 0 1 10 6 /usr/bin/find' " do
      expected_val = {"minute"=>"2 11 45", "hour"=>"0", "dayofmonth"=>"1", "month"=>"10", "dayofweek"=>"6", "command"=>"/usr/bin/find"}
      response = @cron_expression_algorithm.parse("2,11,45 0 1 10 6 /usr/bin/find")
      expect(response).to eq expected_val
    end

    it "when expression is incremental expression with range '2,11,45 0 1-10/2 10 6 /usr/bin/find' " do
      expected_val = {"minute"=>"2 11 45", "hour"=>"0", "dayofmonth"=>"1 3 5 7 9", "month"=>"10", "dayofweek"=>"6", "command"=>"/usr/bin/find"}
      response = @cron_expression_algorithm.parse("2,11,45 0 1-10/2 10 6 /usr/bin/find")
      expect(response).to eq expected_val
    end
  end

  context "When expression is Invalid:" do
    it "when expression contains extra * where expression is '**/15 0 1,15 * 1-5 /usr/bin/find' " do
      expect { @cron_expression_algorithm.parse("**/15 0 1,15 * 1-5 /usr/bin/find") }.to raise_error(CronParseConfiguration::ExpressionError)
    end

    it "when expression has minute incremental value bigger than allowed values where example input '*/67 0 1,15 * 1-5 /usr/bin/find' " do
      expect { @cron_expression_algorithm.parse("*/67 0 1,15 * 1-5 /usr/bin/find") }.to raise_error(CronParseConfiguration::ExpressionError)
    end

    it "when expression has minute incremental contains * where example input '* 0 1,* * 1-5 /usr/bin/find' " do
      expect { @cron_expression_algorithm.parse("* 0 1,* * 1-5 /usr/bin/find") }.to raise_error(CronParseConfiguration::ExpressionError)
    end

    it "when expression has day value greater than 6 where example input '* 0 1,15 * 10 /usr/bin/find' " do
      expect { @cron_expression_algorithm.parse("* 0 1,15 * 10 /usr/bin/find") }.to raise_error(CronParseConfiguration::ExpressionError)
    end
  end
end
