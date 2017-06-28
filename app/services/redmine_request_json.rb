class RedmineRequestJson
  def initialize(offset)
    @offset = offset
    @res = nil
    @response_body = nil
  end

  def fetch_json_from_redmine
    http_request
    extract_request_time_entries
    @response_body
  end

  private

  def http_request
    uri = URI('https://redmine.renuo.ch/time_entries.json?')
    params = { limit: '100', offset: (@offset * 100).to_s, key: ENV['REDMINE_API_KEY'] }
             .merge(NotAffectingInvestment.new.hash_queries)
    uri.query = URI.encode_www_form(params)

    @res = Net::HTTP.get_response(uri)
  end

  def extract_request_time_entries
    body = @res.body
    @response_body = JSON.parse(body)['time_entries']
  end
end
