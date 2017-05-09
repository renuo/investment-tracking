require 'rails_helper'

RSpec.describe OpenInvestmentTimeCalculator, type: :service do
  describe '#add_time_entries_to_employees' do
    before(:each) do
      Employee.create(redmine_user_id: 1, name: 'Max Muster', open_investment_time: 2)
      Employee.create(redmine_user_id: 2, name: 'Hans Meier', open_investment_time: 79)
    end

    context 'the open investment time is not over 80h' do
      let(:time_entries) do
        { { redmine_user_id: 1, name: 'Max Muster' } => [{ 'user' => { 'name' => 'Max Muster', 'id' => 1 },
                                                           'project' => { 'id' => 1 }, 'hours' => 10 }],
          { redmine_user_id: 2, name: 'Hans Meier' } => [{ 'user' => { 'name' => 'Hans Meier', 'id' => 2 },
                                                           'project' => { 'id' => 129 }, 'hours' => 2 },
                                                         { 'user' => { 'name' => 'Hans Meier', 'id' => 2 },
                                                           'project' => { 'id' => 140 }, 'hours' => 2 }] }
      end

      it 'adds the time entries to the existing investment time of the db' do
        updated_employees = described_class.new.sum_entries_rely_on_project_id(time_entries)
        expect(updated_employees[0].open_investment_time).to be(4.5)
        expect(updated_employees[1].open_investment_time).to be(75.0)
      end
    end

    context 'the open investment time is over 80h' do
      let(:time_entries) do
        { { redmine_user_id: 1, name: 'Max Muster' } => [{ 'user' => { 'name' => 'Max Muster', 'id' => 1 },
                                                           'project' => { 'id' => 1 }, 'hours' => 10 }],
          { redmine_user_id: 2, name: 'Hans Meier' } => [{ 'user' => { 'name' => 'Hans Meier', 'id' => 2 },
                                                           'project' => { 'id' => 1 }, 'hours' => 10 }] }
      end

      it 'adds the time entries to the existing investment time of the db' do
        updated_employees = described_class.new.sum_entries_rely_on_project_id(time_entries)
        expect(updated_employees[0].open_investment_time).to be(4.5)
        expect(updated_employees[1].open_investment_time).to be(80.0)
      end
    end
  end
end
