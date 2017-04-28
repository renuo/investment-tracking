require 'rails_helper'

RSpec.describe RedmineInvestmentProjects, type: :service do
  describe '#all_investment_projects_id' do
    it 'return all the investment projects in an array' do
      expect(described_class.new.ids).to eq([138, 129, 141, 130, 139, 140])
    end
  end
end
