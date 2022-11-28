require_relative "../driver"

RSpec.describe Driver do
  before :all do
    @driver = Driver.new
  end

  it "it should return nil if no arguments is passed" do
    response = @driver.input_handler
    expect(response).to eq nil
  end
end
