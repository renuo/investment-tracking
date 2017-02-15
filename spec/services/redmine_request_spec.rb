require 'rails_helper'

RSpec.describe RedmineRequest, type: :service do
  let(:url_report_path) { '/time_entries/report.csv?' }
  subject { described_class.new(url_report_path) }

  describe '#initialize' do
    it 'builds a correct url' do
      expect(subject.instance_variable_get('@url'))
        .to eq(URI('https://redmine.renuo.ch/time_entries/report.csv?utf8=%E2%9C%93&f%5B%5D=spent_on&op%5Bspent_on%5D=
%3E%3D&v%5Bspent_on%5D%5B%5D=2017-01-30&f%5B%5D=&columns=month&criteria%5B%5D=user&key=' + ENV['REDMINE_API_KEY']))
    end
  end

  describe '#request_redmine_for_entries' do
    it 'makes a http request' do
      stub = stub_request(:any, subject.instance_variable_get('@url'))
      subject.request_redmine_for_entries
      expect(stub).to have_been_requested
    end
  end
end
