require 'rails_helper'

RSpec.describe HashConcatenator, type: :service do
  let(:total_entries) { [{ 'User' => 'Max Muster', 'Total time' => '3.0' }] }

  describe '#concatenate' do
    it 'concatenate the hashes if has investment time' do
      investment_entries = [{ 'User' => 'Max Muster', 'Total time' => '0.6' }]
      expected_result = [{ 'name' => 'Max Muster', 'worked_total_hours' => 0.6, 'worked_investment_hours' => 3.0 }]
      expect(described_class.new(total_entries, investment_entries).concatenate)
        .to eq(expected_result)
    end
  end
end
