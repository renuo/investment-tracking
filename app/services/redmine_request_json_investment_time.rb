class RedmineRequestJsonInvestmentTime
  def initialize
    @latest_import_reached = false

    @offset = 0

    @response_body = nil

    @new_time_entries = []

    @newest = nil

    @date_of_latest_import = Import.last['latest_import']

    @data_for_database = nil

  end

  def fetch_json_from_redmine
    if !@latest_import_reached
      http_request(@offset)
      add_new_entries
      @offset += 1
      fetch_json_from_redmine
    end

    @date_of_latest_import  = @response_body.first["created_on"]

    calculate_entries_for_db

    rename_hashes

    @newest
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
        if entry['project']['id'] == 129 ||  entry['project']['id'] == 130 || entry['project']['id'] == 139 || entry['project']['id'] == 140
          @new_time_entries << {"user_id" => entry["user"]["id"], "name" => entry["user"]["name"], "hours" => entry["hours"]}
        end
      else
        @latest_import_reached = true
        break
      end
    end
  end

  def calculate_entries_for_db
    @newest = @new_time_entries.group_by { |hash| hash["user_id"]}.map do |id, hashes|
      hashes.reduce do |hash, next_hash|
        hash.merge(next_hash) { |key, v1, v2| v1 == v2 ? v1 : (v1 + v2)}
      end
    end
  end

  def rename_hashes
    @newest.each do |entry|
      entry['used_investment_time'] = entry.delete('hours')
    end
  end
end
