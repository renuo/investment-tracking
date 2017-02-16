require 'rails_helper'

RSpec.describe RedmineRequest, type: :service do
  subject { described_class.new }
  describe '#request_redmine_for_entries' do
    it 'makes a http request' do
      stub = stub_request(:any, subject.instance_variable_get('@url'))
      subject.request_redmine_for_entries
      expect(stub).to have_been_requested
    end
  end
end
