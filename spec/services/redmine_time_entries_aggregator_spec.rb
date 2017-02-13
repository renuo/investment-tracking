require 'rails_helper'

RSpec.describe RedmineTimeEntriesAggregator, type: :service do
  subject { described_class.new }

  before(:each) do
    @mock_aggregator = RedmineTimeEntriesAggregator.new
    @mock_data = [{ 'user' => { 'id' => 1, 'name' => 'Max Muster' }, 'hours' => 0.5 }, { 'user' => { 'id' => 1, 'name' => 'Max Muster' }, 'hours' => 1 }]
  end

  describe 'find name of id' do
    it 'takes out every name with every matching id' do
      @find_name_and_id = @mock_aggregator.find_name_of_id(@mock_data)
      expect(@find_name_and_id).to eq([{ id: 1, name: 'Max Muster' }])
    end
  end

  describe 'sum entries' do
    it 'sums the entries' do
      @summed_entries = @mock_aggregator.sum_entries(@mock_data)
      expect(@summed_entries).to eq([{ id: 1, hours: 1.5, name: 'Max Muster' }])
    end
  end

  describe 'calculate investment time user' do
    it 'calculates investment time per user' do
      @calculated_time = @mock_aggregator.calculate_investment_time_user(@mock_aggregator.sum_entries(@mock_data))
      expect(@calculated_time).to eq([{ id: 1, hours: 1.5, name: 'Max Muster', all_investment_time: 0.3 }])
    end
  end

  describe 'calculate investment time user' do
    it 'calculates investment time per user' do
      @calculated_time = @mock_aggregator.calculate_investment_time_user(@mock_aggregator.sum_entries(@mock_data))
      expect(@calculated_time).to eq([{ id: 1, hours: 1.5, name: 'Max Muster', all_investment_time: 0.3 }])
    end
  end
end
