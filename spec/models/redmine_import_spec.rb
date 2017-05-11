require 'rails_helper'

RSpec.describe RedmineImport, type: :model do
  it 'is valid with valid attributes' do
    expect(RedmineImport.new).to be_valid
  end
end
