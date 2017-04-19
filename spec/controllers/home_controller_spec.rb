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

      Import.create(latest_import: '2017-04-10T00:00:00Z')
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
