require 'rails_helper'

RSpec.describe NotAffectingInvestment do
  subject { described_class.new }
  describe '#array_quries' do
    it 'returns the queries as an array' do
      expect(subject.array_queries).to eq([['f[]', 'issue.cf_20'], ['op[issue.cf_20]', '!'], ['v[issue.cf_20][]', 0]])
    end
  end

  describe '#hash_queries' do
    it 'returns the queries as a hash' do
      expect(subject.hash_queries).to eq('f[]' => 'issue.cf_20',
                                         'op[issue.cf_20]' => '!',
                                         'v[issue.cf_20][]' => 0)
    end
  end
end
