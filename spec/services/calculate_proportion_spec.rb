require 'rails_helper'

RSpec.describe CalculateProportion, type: :service do
  let(:aggregated_time) do
    [{ 'investment_time_total' => 0.6, 'name' => 'Max Muster', 'worked_hours' => '3.0',
       'worked_investment_hours' => '0.6', 'open_investment_time' => 0.0 }]
  end

  describe 'add proportions' do
    it 'calculates and adds proportions to each user' do
      expected_solution = [{ 'investment_time_total' => 0.6, 'name' => 'Max Muster', 'worked_hours' => '3.0',
                             'worked_investment_hours' => '0.6', 'open_investment_time' => 0.0,
                             'percent_used_to_worked' => 20.0, 'percent_used_to_open' => 0.0 }]
      expect(described_class.new(aggregated_time).add_proportions).to eq(expected_solution)
    end
  end
end
