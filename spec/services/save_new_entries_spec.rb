require 'rails_helper'

RSpec.describe SaveNewEntries do
  let(:time_entries) do
    [{ 'employee_id' => 100, 'employee_name' => 'Hans Meier', 'worked_hours' => 10, 'used_investment_time' => 0 }]
  end

  describe 'save new entries to db' do
    context 'when employee is new' do
      it 'adds the entries to the db' do
        described_class.new(time_entries).save_new_entries_to_db
        expect(Employee.exists?(employee_id: 100)).to be true
      end
    end

    context 'employee_id already exists' do
      it 'overwrites the open investment time' do
        Employee.new(employee_id: 100, employee_name: 'Hans Meier', 'open_investment_time': 3).save
        described_class.new(time_entries).save_new_entries_to_db
        expect(Employee.find_by(employee_id: 100).open_investment_time).to be(5.0)
      end
    end

    context 'open investment time is over 80 hours' do
      it 'adds 80 hours of open investment time' do
        Employee.new(employee_id: 100, employee_name: 'Hans Meier', 'open_investment_time': 79).save
        described_class.new(time_entries).save_new_entries_to_db
        expect(Employee.find_by(employee_id: 100).open_investment_time).to be(80.0)
      end
    end
  end
end
