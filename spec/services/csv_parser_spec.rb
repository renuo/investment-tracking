require 'rails_helper'

RSpec.describe CsvParser, type: :service do
  subject do
    described_class.new(double(:response, body:
    "User,2017-1,2017-2,Total time\nEmily Wangler,\"\",7.26,7.26\nPascal Andermatt,0.85,24.24,25.09\n"))
  end

  describe 'request redmine for entries' do
    it 'makes a http request' do
      expected_solution = [{ 'User' => 'Emily Wangler', '2017-1' => '', '2017-2' => '7.26', 'Total time' => '7.26' },
                           { 'User' => 'Pascal Andermatt', '2017-1' => '0.85', '2017-2' => '24.24',
                             'Total time' => '25.09' }]
      expect(subject.parse_to_hash).to eq(expected_solution)
    end
  end
end
