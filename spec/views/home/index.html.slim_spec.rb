require 'rails_helper'

RSpec.describe 'home/index.html.slim', type: :view do
  describe 'time_entries' do
    it 'it shows the data of a user' do
      assign(:times_per_users, [{ 'name' => 'Max Muster', 'open_investment_time' => 1,
                                  'percent_used_to_worked' => 2, 'percent_used_to_open' => 2 }])

      render

      expect(rendered).to include 'Max Muster'
    end
  end
end
