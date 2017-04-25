require 'rails_helper'

RSpec.describe CsvAndDbEntriesCombiner, type: :service do
  let(:time_entries_csv) do
    [{ 'name' => 'Max Muster', 'worked_total_hours' => 80,
       'worked_investment_hours' => 10, 'proportion_used_to_worked' => 12.5 }]
  end

  describe '#combine_csv_and_db_entries' do
    before(:each) do
      Employee.create!(name: 'Max Muster', redmine_user_id: 1, open_investment_time: 70)
    end

    it 'calculates_the_percent_filled_out_in_the_progress_bar' do
      expected_solution = [{ 'name' => 'Max Muster',
                             'worked_total_hours' => 80,
                             'worked_investment_hours' => 10,
                             'proportion_used_to_worked' => 12.5,
                             'open_investment_time' => 70.0 }]
      expect(described_class.new(time_entries_csv).combine_csv_and_db_entries).to eq(expected_solution)
    end
  end
end
