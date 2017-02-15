require 'rails_helper'

RSpec.describe CsvParser, type: :service do
  subject { described_class.new(url_report_path) }

  describe 'request redmine for entries' do
    it 'makes a http request' do
    end
  end
end
