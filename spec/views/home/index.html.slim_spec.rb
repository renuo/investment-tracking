require 'rails_helper'

RSpec.describe 'home/index.html.slim', type: :view do
  describe 'time_entries' do
    it 'it shows the data of a user' do
      assign(:data_to_display, [{ 'name' => 'Max Muster', 'open_investment_time' => 1 }])

      render

      expect(rendered).to include 'Max Muster'
    end
  end
end
