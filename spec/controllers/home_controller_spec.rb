require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      stub_request(:get, %r{/redmine.renuo.ch/time_entries.json})
        .to_return(status: 200, body: '{"time_entries":
[{ "user": { "name": "Max", "id": 1 }, "project": { "id": 1 }, "hours": 10, "created_on": "2017-04-11T00:00:00Z"},
{ "user": { "name": "Max", "id": 1 }, "project": { "id": 1 }, "hours": 10, "created_on": "2017-04-09T00:00:00Z"}]}',
                   headers: {})

      stub_request(:get, %r{/redmine.renuo.ch/time_entries/report.csv})
        .to_return(status: 200, body: 'Test', headers: {})

      RedmineImport.create(created_at: 'Mon, 10 April 2017 00:00:00 CEST +02:00')
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
