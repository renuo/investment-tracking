require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe '#progress_bar_calculator' do
    it 'should calculate the right width of the progress bar' do
      open_investment_time_in_hours = { 'open_investment_time' => 60 }
      expect(helper.amount_of_filled_progress_bar(open_investment_time_in_hours)).to eq(75)
    end
  end

  describe '#progress_bar_status' do
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

  describe '#proportion_used_to_worked' do
    it 'calculates the proportion from used investment hours to worked hours' do
      entry = { 'worked_investment_hours' => 2.0, 'worked_total_hours' => 10.0 }
      expect(helper.proportion_used_to_worked(entry)).to eq(20.0)
    end
  end
end

# (entry['worked_investment_hours'] / entry['worked_total_hours'] * 100).round(2)
