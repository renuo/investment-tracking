require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      stub_request(:get, %r{/redmine.renuo.ch/})
        .to_return(status: 200, body: 'Test', headers: {})
    end

    it 'returns http success' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #check' do
    it 'returns http success' do
      get :check
      expect(response).to have_http_status(:success)
    end
  end
end
