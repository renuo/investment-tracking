require 'rails_helper'

RSpec.describe 'home/index.html.slim', type: :view do
  describe 'time_entries' do
    it 'it shows the data of a user' do
      assign(:employee, [{ 'name' => 'Max Muster', 'open_investment_time' => 1,
                           'worked_total_hours' => 10, 'worked_investment_hours' => 0 }])

      render

      expect(rendered).to include 'Max Muster'
      expect(rendered).to have_selector('.progress-bar-success[style="width: 1.25%"]')
      expect(rendered).to include '0h'
    end
  end
end
