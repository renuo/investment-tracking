require 'rails_helper'

RSpec.describe CalculateProportion, type: :service do
  let(:time_entries) do
    [{ 'name' => 'Hans Meier', 'worked_total_hours' => 40, 'worked_investment_hours' => 0.0 },
     { 'name' => 'Max Meier', 'worked_total_hours' => 35, 'worked_investment_hours' => 5.0 }]
  end

  describe 'calculate' do
    it 'calculates additional entries and adds it to the hash' do
      expected_solution = [{ 'name' => 'Hans Meier', 'worked_total_hours' => 40, 'worked_investment_hours' => 0,
                             'proportion_used_to_worked' => 0.0 },
                           { 'name' => 'Max Meier', 'worked_total_hours' => 35, 'worked_investment_hours' => 5.0,
                             'proportion_used_to_worked' => 14.29 }]
      expect(described_class.new(time_entries).calculate).to eq(expected_solution)
    end
  end
end
