require 'rails_helper'

RSpec.describe RedmineRequest, type: :service do
  subject { described_class.new }

  before(:each) do
    @mock_aggregator = RedmineRequest.new
    @mock_data = [{ 'user' => { 'id' => 1, 'name' => 'Max Muster' }, 'hours' => 0.5 },
                  { 'user' => { 'id' => 1, 'name' => 'Max Muster' }, 'hours' => 1 }]
  end
end
