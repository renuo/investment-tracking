require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  describe '#initialize' do
    let(:application_record) { Class.new(described_class) }

    it 'gets initialized as anonymous class' do
      expect(application_record).to be_truthy
    end
  end
end
