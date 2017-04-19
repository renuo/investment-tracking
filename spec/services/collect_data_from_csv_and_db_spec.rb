require 'rails_helper'

RSpec.describe CollectDataFromCsvAndDb, type: :service do
  let(:time_entries_csv) do
    [{ 'name' => 'Max Muster', 'worked_total_hours' => 80,
       'worked_investment_hours' => 10, 'proportion_used_to_worked' => 12.5 }]
  end

  describe 'add percent' do
    before(:each) do
      Employee.create!(name: 'Max Muster', redmine_user_id: 1, open_investment_time: 70)
    end

    it 'calculates the percent filled out in the progress bar ' do
      expected_solution = [{ 'name' => 'Max Muster',
                             'worked_total_hours' => 80,
                             'worked_investment_hours' => 10,
                             'proportion_used_to_worked' => 12.5,
                             'open_investment_time' => 70.0 }]
      expect(described_class.new(time_entries_csv).merge).to eq(expected_solution)
    end
  end
end
