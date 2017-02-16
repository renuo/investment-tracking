require 'rails_helper'

RSpec.describe 'time_entries/index.html.slim', type: :view do
  describe 'time_entries' do
    it 'it shows the data of a user' do
      assign(:redmine_request_it_griffin, [{'name' => 'Max Muster' }])

      render

      expect(rendered).to include 'Max Muster'
    end
  end
end
