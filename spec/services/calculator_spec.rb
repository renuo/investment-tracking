require 'rails_helper'

RSpec.describe Calculator, type: :service do
  let(:time_entries) do
    [{ 'name' => 'Hans Meier', 'worked_total_hours' => 35, 'worked_investment_hours' => 1.0 },
     { 'name' => 'Max Meier', 'worked_total_hours' => 35 }]
  end

  describe 'calculate' do
    it 'calculates additional entries and adds it to the hash' do
      expected_solution = [{ 'name' => 'Hans Meier', 'worked_total_hours' => 35, 'worked_investment_hours' => 1.0,
                             'investment_time_total' => 7.0, 'open_investment_time' => 6.0,
                             'proportion_used_to_worked' => 2.86, 'reached_quota_percentage' => 7.5 },
                           { 'name' => 'Max Meier', 'worked_total_hours' => 35,
                             'investment_time_total' => 7.0, 'worked_investment_hours' => 0,
                             'open_investment_time' => 7.0, 'proportion_used_to_worked' => 0.0,
                             'reached_quota_percentage' => 8.75 }]
      expect(described_class.new(time_entries).calculate).to eq(expected_solution)
    end
  end
end
