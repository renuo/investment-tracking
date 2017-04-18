require 'rails_helper'

RSpec.describe SaveEntries do
  let(:concatenated_entries) do
    [{ 'employee_id' => 100, 'employee_name' => 'Hans Meier', 'worked_hours' => 10, 'used_investment_time' => 0 }]
  end

  subject { described_class.new(concatenated_entries) }

  describe 'save to db' do
    it 'saves the entry and the import time to the db' do
      subject.save_to_db
      expect(Employee.all.size).to eq 1
      expect(Import.all.size).to eq 1
    end
  end
end
