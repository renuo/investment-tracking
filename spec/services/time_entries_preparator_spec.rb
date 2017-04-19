require 'rails_helper'

RSpec.describe TimeEntriesPreparator, type: :service do
  let(:newest_time_entries) do
    [{ 'user' => { 'name' => 'Max', 'id' => 1 }, 'project' => { 'id' => 1 }, 'hours' => 10 },
     { 'user' => { 'name' => 'Max', 'id' => 1 }, 'project' => { 'id' => 140 }, 'hours' => 1 },
     { 'user' => { 'name' => 'Leo', 'id' => 2 }, 'project' => { 'id' => 129 }, 'hours' => 2 },
     { 'user' => { 'name' => 'Duda', 'id' => 3 }, 'project' => { 'id' => 140 }, 'hours' => 3 }]
  end

  describe 'sort and group' do
    it 'sorts by created on and groups by employee' do
      expected_solution =
        { { redmine_user_id: 1, name: 'Max' } => [{ 'user' => { 'name' => 'Max', 'id' => 1 },
                                                    'project' => { 'id' => 1 }, 'hours' => 10 },
                                                  { 'user' => { 'name' => 'Max', 'id' => 1 },
                                                    'project' => { 'id' => 140 }, 'hours' => 1 }],
          { redmine_user_id: 2, name: 'Leo' } => [{ 'user' => { 'name' => 'Leo', 'id' => 2 },
                                                    'project' => { 'id' => 129 }, 'hours' => 2 }],
          { redmine_user_id: 3, name: 'Duda' } => [{ 'user' => { 'name' => 'Duda', 'id' => 3 },
                                                     'project' => { 'id' => 140 }, 'hours' => 3 }] }

      expect(described_class.new(newest_time_entries).sort_and_group).to eq(expected_solution)
    end
  end
end
