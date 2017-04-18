require 'rails_helper'

RSpec.describe EntriesConcatenator, type: :service do
  let(:total_time) do
    [{ 'employee_id' => 100, 'employee_name' => 'Hans Meier', 'worked_hours' => 10.0 }]
  end

  let(:investment_time) do
    [{ 'employee_id' => 100, 'employee_name' => 'Hans Meier', 'used_investment_time' => 1.0 }]
  end

  describe 'merge entries' do
    context 'when investment time has been used' do
      let(:investment_time) do
        [{ 'employee_id' => 100, 'employee_name' => 'Hans Meier', 'used_investment_time' => 1.0 }]
      end

      it 'merges the total time and the investment time' do
        expect(described_class.new(investment_time, total_time).merge_entries)
          .to eq([{ 'employee_id' => 100, 'employee_name' => 'Hans Meier',
                    'used_investment_time' => 1.0, 'worked_hours' => 10.0 }])
      end
    end

    context 'when no investment time has been taken' do
      let(:investment_time) { [] }
      it 'merges the total time and the investment time' do
        expect(described_class.new(investment_time, total_time).merge_entries)
          .to eq([{ 'employee_id' => 100, 'employee_name' => 'Hans Meier',
                    'used_investment_time' => 0.0, 'worked_hours' => 10.0 }])
      end
    end
  end
end
