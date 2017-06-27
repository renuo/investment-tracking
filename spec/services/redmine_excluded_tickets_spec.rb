require 'rails_helper'

RSpec.describe RedmineExcludedTickets do
  subject { described_class.new }
  describe '#ticket_nrs' do
    it 'gives back an array with all investment issue nrs' do
      expect(subject.ticket_nrs).to eq([2949, 6199])
    end
  end
end
