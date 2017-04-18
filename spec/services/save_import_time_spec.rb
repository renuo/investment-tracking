require 'rails_helper'

RSpec.describe SaveImportTime do
  describe 'save current time to db' do
    context 'when db is empty' do
      it 'adds the current time to the import db' do
        described_class.new.save_current_time_to_db
        expect(Import.all.size).to be 1
      end
    end

    context 'when db already has an entry' do
      it 'adds the current time to the import db' do
        Import.new(latest_import: '2017-30-01T00:00:00Z').save
        described_class.new.save_current_time_to_db
        expect(Import.all.size).to be 2
      end
    end
  end
end
