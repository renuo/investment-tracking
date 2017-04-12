require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      stub_request(:get, /redmine.renuo.ch/).to_return(status: 200, body: 'Test', headers: {})
    end

    context 'not being logged in' do
      it 'fails (with 401 unauthorized)' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'being logged in' do
      before(:each) do
        http_basic_auth
      end

      it 'succeeds (with 200 ok)' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #check' do
    it 'returns http success' do
      get :check
      expect(response).to have_http_status(:success)
    end
  end
end
