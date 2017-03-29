require 'rails_helper'

RSpec.describe SortTime, type: :service do
  let(:aggregated_time) do
RSpec.describe SortByProportion, type: :service do
  let(:time_entries) do
    [{ 'name' => 'Hans Meier', 'proportion_used_to_worked' => 0.2 },
     { 'name' => 'Max Muster', 'proportion_used_to_worked' => 0.1 }]
  end

  describe 'request redmine for entries' do
    it 'makes a http request' do
      expected_solution = [{ 'name' => 'Max Muster', 'proportion_used_to_worked' => 0.1 },
                           { 'name' => 'Hans Meier', 'proportion_used_to_worked' => 0.2 }]
      expect(described_class.new(aggregated_time).sort_by_proportion).to eq(expected_solution)
      expect(described_class.new(time_entries).sort_by_proportion).to eq(expected_solution)
    end
  end
end
