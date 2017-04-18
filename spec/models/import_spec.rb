require 'rails_helper'

RSpec.describe Import, type: :model do
  it 'is valid with valid attributes' do
    expect(Import.new).to be_valid
  end
end
