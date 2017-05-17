require 'rails_helper'

RSpec.describe 'Home', type: :request do
  let(:auth_headers) do
    {
      HTTP_AUTHORIZATION:
        ActionController::HttpAuthentication::Basic.encode_credentials(ENV['BASIC_AUTH_USER'],
                                                                       ENV['BASIC_AUTH_PASSWORD'])
    }
  end

  context 'initial test' do
    it 'should check if the app is ok and connected to a database' do
      get '/home/check'
      expect(response).to have_http_status(200)
      expect(response.body).to eq('1+2=3')
    end
  end

  describe '#index' do
    let(:data) do
      [{ 'name' => 'Hans Meier', 'worked_total_hours' => 12.0, 'worked_investment_hours' => 2.0 },
       { 'name' => 'Max Muller', 'worked_total_hours' => 8.0, 'worked_investment_hours' => 4.0 }]
    end

    before do
      Employee.create!([{ name: 'Hans Meier', redmine_user_id: 2, open_investment_time: 4 },
                        { name: 'Max Muller', redmine_user_id: 1, open_investment_time: 3 }])
      allow_any_instance_of(CsvService).to receive(:time_entries).and_return(data)
    end
    describe 'json format' do
      it 'returns correct data' do
        get data_path, params: { format: :json }, headers: auth_headers
        json_response = JSON.parse(response.body, symbolize_names: true)[:employees]
        expect(json_response[0]).to eq(name: 'Hans Meier',
                                       worked_total_hours: 12.0,
                                       worked_investment_hours: 2.0,
                                       open_investment_time: 4.0)

        expect(json_response[1]).to eq(name: 'Max Muller',
                                       worked_total_hours: 8.0,
                                       worked_investment_hours: 4.0,
                                       open_investment_time: 3.0)
      end
    end
  end
end
