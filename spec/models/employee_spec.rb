require 'rails_helper'

RSpec.describe Employee, type: :model do
  it 'is valid with valid attributes' do
    expect(Employee.new).to be_valid
  end
end
