require 'rails_helper'

RSpec.describe RedmineInvestmentProjects do
  subject { described_class.new }
  describe '#ids' do
    it 'gives back an array with all investment project ids' do
      expect(subject.ids).to eq([138, 152, 129, 141, 130, 139, 140])
    end
  end
end
