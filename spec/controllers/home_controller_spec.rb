require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #check' do
    it 'returns http success' do
      get :check
      expect(response).to have_http_status(:success)
    end
  end
end
