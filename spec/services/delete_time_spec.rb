require 'rails_helper'

RSpec.describe DeleteTime, type: :service do
  let(:sorted_times) do
    [{ 'name' => 'Total time', 'percent_used_to_worked' => 0.1 },
     { 'name' => 'Hans Meier', 'percent_used_to_worked' => 0.2 }]
  end

  describe 'delete total time' do
    it 'deletes the hash with total time' do
      expected_solution = [{ 'name' => 'Hans Meier', 'percent_used_to_worked' => 0.2 }]
      expect(described_class.new(sorted_times).delete_total_time).to eq(expected_solution)
    end
  end
end