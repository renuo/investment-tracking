require 'rails_helper'

RSpec.describe AggregateNewestEntries, type: :service do
  let(:time_entries) do
    [{ 'employee_id' => 100, 'employee_name' => 'Hans Meier', 'worked_hours' => 10.0 },
     { 'employee_id' => 100, 'employee_name' => 'Hans Meier', 'worked_hours' => 2.0 }]
  end

  describe 'aggregate' do
    it 'aggregates the times entries of an employee id' do
      expect(described_class.new(time_entries).aggregate)
        .to eq([{ 'employee_id' => 100, 'employee_name' => 'Hans Meier', 'worked_hours' => 12.0 }])
    end
  end
end
