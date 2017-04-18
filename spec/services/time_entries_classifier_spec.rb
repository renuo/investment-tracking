require 'rails_helper'

RSpec.describe TimeEntriesClassifier do
  describe 'group entries by project' do
    let(:newest_time_entries) do
      [{ 'user' => { 'name' => 'Max', 'id' => 1 }, 'project' => { 'id' => 1 }, 'hours' => 1 },
       { 'user' => { 'name' => 'Leo', 'id' => 2 }, 'project' => { 'id' => 129 }, 'hours' => 2 },
       { 'user' => { 'name' => 'Duda', 'id' => 3 }, 'project' => { 'id' => 140 }, 'hours' => 3 }]
    end

    subject { described_class.new(newest_time_entries) }

    it 'groups the entries into total time and investment time' do
      expect(subject.group_entries_by_project)
        .to eq([[{ 'employee_id' => 2, 'employee_name' => 'Leo', 'used_investment_time' => 2 },
                 { 'employee_id' => 3, 'employee_name' => 'Duda', 'used_investment_time' => 3 }],
                [{ 'employee_id' => 1, 'employee_name' => 'Max', 'worked_hours' => 1 },
                 { 'employee_id' => 2, 'employee_name' => 'Leo', 'worked_hours' => 2 },
                 { 'employee_id' => 3, 'employee_name' => 'Duda', 'worked_hours' => 3 }]])
    end
  end
end
