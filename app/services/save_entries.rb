class SaveEntries
  def initialize(concatenated_entries)
    @concatenated_entries = concatenated_entries
  end

  def save_to_db
    save_new_entries_to_db
    save_import_time_to_db
  end

  private

  def save_new_entries_to_db
    SaveNewEntries.new(@concatenated_entries).save_new_entries_to_db
  end

  def save_import_time_to_db
    SaveImportTime.new.save_current_time_to_db
  end
end
