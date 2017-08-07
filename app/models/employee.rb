class Employee < ApplicationRecord
  validates :name, presence: true
  validates :redmine_user_id, presence: true
  validates :open_investment_time, numericality:
    { less_than_or_equal_to: InvestmentTracking::Application::MAXIMUM_OF_INVESTMENT_TIME }
end
