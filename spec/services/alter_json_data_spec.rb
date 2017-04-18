require 'rails_helper'

RSpec.describe AlterJsonData do
  let(:all_time_entries) do
    [{ 'user' => { 'name' => 'Max', 'id' => 1 }, 'project' => { 'id' => 1 }, 'hours' => 10 },
     { 'user' => { 'name' => 'Max', 'id' => 1 }, 'project' => { 'id' => 140 }, 'hours' => 1 },
     { 'user' => { 'name' => 'Leo', 'id' => 2 }, 'project' => { 'id' => 129 }, 'hours' => 2 },
     { 'user' => { 'name' => 'Duda', 'id' => 3 }, 'project' => { 'id' => 140 }, 'hours' => 3 }]
  end

  describe 'alter json to final data' do
    it 'aggregates the time entries' do
      expected_solution = [{ 'employee_id' => 1, 'employee_name' => 'Max',
                             'worked_hours' => 11, 'used_investment_time' => 1 },
                           { 'employee_id' => 2, 'employee_name' => 'Leo',
                             'worked_hours' => 2, 'used_investment_time' => 2 },
                           { 'employee_id' => 3, 'employee_name' => 'Duda',
                             'worked_hours' => 3, 'used_investment_time' => 3 }]
      expect(described_class.new(all_time_entries).alter_json_to_final_data).to eq(expected_solution)
    end
  end
end
