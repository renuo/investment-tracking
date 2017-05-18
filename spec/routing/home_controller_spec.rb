require 'rails_helper'

RSpec.describe HomeController, type: :routing do
  describe '/api/v1/data' do
    it 'routes to #index' do
      expect(get: '/api/v1/data').to route_to('home#index')
    end
  end
end
