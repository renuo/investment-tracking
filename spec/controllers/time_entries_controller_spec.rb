require 'rails_helper'

RSpec.describe TimeEntriesController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      stub_request(:get, /redmine.renuo.ch/)
        .to_return(status: 200, body: 'Test', headers: {})
    end

    it 'returns http success' do
      get :index
      expect(response.status).to eq(200)
    end
  end
end
