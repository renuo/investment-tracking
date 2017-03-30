require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe 'progress_bar_status' do
    it 'should return the progress-bar-danger if the quantity is more or equal than 60' do
      open_investment_time_in_hours = { 'open_investment_time' => 60 }
      expect(helper.progress_bar_status(open_investment_time_in_hours)).to eq('progress-bar-danger')
    end
    it 'should return the progress-bar-warning if the quantity is less than 60 and more than 40' do
      open_investment_time_in_hours = { 'open_investment_time' => 59 }
      expect(helper.progress_bar_status(open_investment_time_in_hours)).to eq('progress-bar-warning')
    end
    it 'should return the progress-bar-warning if the quantity is less than 60 and more than 40' do
      open_investment_time_in_hours = { 'open_investment_time' => 40 }
      expect(helper.progress_bar_status(open_investment_time_in_hours)).to eq('progress-bar-warning')
    end
    it 'should return the progress-bar-success if the quantity is less 40' do
      open_investment_time_in_hours = { 'open_investment_time' => 39 }
      expect(helper.progress_bar_status(open_investment_time_in_hours)).to eq('progress-bar-success')
    end
  end
end
