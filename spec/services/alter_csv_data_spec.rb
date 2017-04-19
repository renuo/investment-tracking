require 'rails_helper'

RSpec.describe AlterCsvData, type: :service do
  subject do
    described_class.new(double(:response, body:
      "User,2017-1,2017-2,Total time\nMax Muller,\"\",1.00,1.00\nErik Muster,1.00,1.00,2.00\n"),
                        double(:response, body:
      "User,2017-1,2017-2,Total time\nMax Muller,\"\",10.00,10.00\nErik Muster,10.00,10.00,20.00\n"))
  end

  describe 'alter csv to final data' do
    it 'alters the data from the redmine request' do
      expected_solution = [{ '2017-1' => '', '2017-2' => '1.00', 'name' => 'Max Muller',
                             'worked_total_hours' => 10.0, 'worked_investment_hours' => 1.0,
                             'proportion_used_to_worked' => 10.0 },
                           { '2017-1' => '1.00', '2017-2' => '1.00', 'name' => 'Erik Muster',
                             'worked_total_hours' => 20.0, 'worked_investment_hours' => 2.0,
                             'proportion_used_to_worked' => 10.0 }]
      expect(subject.alter_csv_to_final_data).to eq(expected_solution)
    end
  end
end
