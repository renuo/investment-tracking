require 'rails_helper'

RSpec.describe CsvParser, type: :service do
  subject { described_class.new }

  before(:each) do
    @mock_aggregator = CsvParser.new
    @mock_data = [{ 'user' => { 'id' => 1, 'name' => 'Max Muster' }, 'hours' => 0.5 },
                  { 'user' => { 'id' => 1, 'name' => 'Max Muster' }, 'hours' => 1 }]
  end
end
