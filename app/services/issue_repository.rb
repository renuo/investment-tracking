class IssueRepository
  def initialize
    @offset = 0
    @date_of_latest_import = RedmineImport.last[:created_at]
    @new_entries_left = true
    @json_from_redmine = nil
    @new_time_entries = []
  end

  def entries_since_latest_import
    while @new_entries_left
      fetch_json_with_new_entries
      sort_by_created_on
      extract_new_entries_from_json
    end

    @new_time_entries
  end

  private

  def fetch_json_with_new_entries
    @json_from_redmine = RedmineRequestJson.new(@offset).fetch_json_from_redmine
    @offset += 1
  end

  def sort_by_created_on
    @json_from_redmine = @json_from_redmine.sort_by { |key| key['created_on'] }.reverse
  end

  def extract_new_entries_from_json
    @json_from_redmine.each do |entry|
      created_on = entry['created_on'].to_datetime
      if created_on > @date_of_latest_import
        @new_time_entries << entry
      else
        @new_entries_left = false
        break
      end
    end
  end
end
