class RedmineRequestJson
  def initialize
    @response_body = nil

    @offset = 0

    @latest_import_reached = false

    @date_of_latest_import = Import.last['latest_import']

    @data_for_database = nil

    @new_time_entries = []
  end

  def fetch_json_from_redmine
    unless @latest_import_reached
      http_request(@offset)
      add_new_entries
      @offset += 1
      fetch_json_from_redmine
    end
    calculate_entries_for_db
  end

  def http_request(offset)
    uri = URI('https://redmine.renuo.ch/time_entries.json?')
    params = { limit: '100', offset: (offset * 100).to_s, key: ENV['REDMINE_API_KEY'] }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    body = res.body

    @response_body = JSON.parse(body)['time_entries']
  end

  def add_new_entries
    @response_body.each do |entry|
      if entry['created_on'] > @date_of_latest_import
        @new_time_entries << entry
      else
        @latest_import_reached = true
        break
      end
    end
  end

  def calculate_entries_for_db
    @new_time_entries.group_by { |key| key['user']['id'] }
  end
end
