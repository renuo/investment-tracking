require 'rails_helper'

RSpec.describe AddPercentOfProgressBar, type: :service do
  let(:entries) do
    [{ 'open_investment_time' => 40 }]
  end

  describe '#add_percent' do
    it 'calculates the percent filled out in the progress bar ' do
      expected_solution = [{ 'open_investment_time' => 40, 'reached_quota_percentage' => 50.0 }]
      expect(described_class.new(entries).add_percent).to eq(expected_solution)
    end
  end
end
