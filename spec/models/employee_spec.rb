require 'rails_helper'

RSpec.describe Employee, type: :model do
  it 'is invalid with attributes' do
    expect(Employee.new).to be_invalid
  end

  it 'is valid if the open investment time is less or equal than 80' do
    valid_employee = Employee.create(redmine_user_id: 1, name: 'Max Muster', open_investment_time: 80)
    expect(valid_employee).to be_valid
  end

  it 'is invalid if the open investment time is greater than 80' do
    invalid_employee = Employee.create(redmine_user_id: 1, name: 'Max Muster', open_investment_time: 81)
    expect(invalid_employee).to be_invalid
  end
end
