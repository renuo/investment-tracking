class RedmineRequest
  def initialize
    @url = create_url
  end

  def request_redmine_for_entries
    http_request
  end

  private

  def create_url
    @url = URI('https://redmine.renuo.ch/time_entries/report.csv?' + query + key)
  end

  def query
    URI.encode_www_form([['utf8', '✓'], ['criteria[]', 'user'],
                         ['f[]', 'spent_on'], ['op[spent_on]', '>='], ['v[spent_on][]', '2017-01-30'],
                         ['f[]', ''],
                         ['c[]', 'project'], ['c[]', 'spent_on'], ['c[]', 'user'],
                         ['c[]', 'activity'], ['c[]', 'issue'], ['c[]', 'comments'],
                         ['c[]', 'hours'],
                         %w(columns month),
                         ['criteria[]', '']].push(*addition_params))
  end

  def addition_params
    []
  end

  def key
    '&key=' + ENV['REDMINE_API_KEY']
  end

  def http_request
    req = Net::HTTP::Get.new(@url)

    Net::HTTP.start(@url.hostname, @url.port, use_ssl: true) do |http|
      http.request(req)
    end
  end
end
