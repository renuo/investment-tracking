require 'rails_helper'

RSpec.describe DeleteTime, type: :service do
  let(:time_entries) do
    [{ 'name' => 'Total time', 'proportion_used_to_worked' => 0.1 },
     { 'name' => 'Hans Meier', 'proportion_used_to_worked' => 0.2 }]
  end

  describe '#delete_total_time' do
    it 'deletes the hash with total time' do
      expected_solution = [{ 'name' => 'Hans Meier', 'proportion_used_to_worked' => 0.2 }]
      expect(described_class.new(time_entries).delete_total_time).to eq(expected_solution)
    end
  end
end
