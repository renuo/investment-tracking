class SaveImportTime
  def initialize
    @adjusted_current_time = nil
  end

  def save_current_time_to_db
    change_structure_of_time
    Import.new(latest_import: @adjusted_current_time).save
  end

  private

  def change_structure_of_time
    @adjusted_current_time = Time.now.utc.to_s.sub(' ', 'T').sub(' UTC', 'Z')
  end
end
