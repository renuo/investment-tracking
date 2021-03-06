require 'rails_helper'

RSpec.describe TimeEntriesUpdater do
  let(:all_time_entries) do
    [{ 'user' => { 'name' => 'Max', 'id' => 1 }, 'project' => { 'id' => 1 }, 'hours' => 10 },
     { 'user' => { 'name' => 'Max', 'id' => 1 }, 'project' => { 'id' => 140 }, 'hours' => 1 },
     { 'user' => { 'name' => 'Leo', 'id' => 2 }, 'project' => { 'id' => 129 }, 'hours' => 2 },
     { 'user' => { 'name' => 'Duda', 'id' => 3 }, 'project' => { 'id' => 1 }, 'hours' => 8 },
     { 'user' => { 'name' => 'Duda', 'id' => 3 }, 'project' => { 'id' => 140 }, 'hours' => 3 }]
  end

  describe '#update_user_and_save' do
    context 'if database is not empty' do
      before(:each) do
        Employee.create(redmine_user_id: 1, name: 'Max', open_investment_time: 2)
        Employee.create(redmine_user_id: 2, name: 'Leo', open_investment_time: 79)
        Employee.create(redmine_user_id: 3, name: 'Duda', open_investment_time: 79)
      end

      it 'adds the new entries to the db' do
        described_class.new(all_time_entries).update_user_and_save

        expect(Employee.find_by(redmine_user_id: 1).open_investment_time).to be(3.5)
        expect(Employee.find_by(redmine_user_id: 2).open_investment_time).to be(77.0)
        expect(Employee.find_by(redmine_user_id: 2).open_investment_time).to be(77.0)
      end
    end

    context 'if database is empty' do
      it 'adds the new entries to the db' do
        described_class.new(all_time_entries).update_user_and_save
        expect(Employee.exists?(redmine_user_id: 1)).to be true
        expect(Employee.exists?(redmine_user_id: 2)).to be true
        expect(Employee.exists?(redmine_user_id: 3)).to be true
      end

      it 'adds the new investment time to the user' do
        described_class.new(all_time_entries).update_user_and_save
        expect(Employee.find_by(redmine_user_id: 1).open_investment_time).to be(1.5)
        expect(Employee.find_by(redmine_user_id: 2).open_investment_time).to be(-2.0)
        expect(Employee.find_by(redmine_user_id: 3).open_investment_time).to be(-1.0)
      end

      it 'adds the current time to the db' do
        expect do
          described_class.new(all_time_entries).update_user_and_save
        end.to change {
          RedmineImport.all.size
        }.by(1)
      end
    end
  end
end
