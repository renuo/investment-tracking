class RedmineRequestCsv
  INVESTMENT_PARAMS = [['f[]', 'project_id'], ['op[project_id]', '=']]
                      .push(*RedmineInvestmentProjects.new.ids.map { |id| ['v[project_id][]', id] }).freeze

  def initialize(investment_params = [])
    @url = create_url(investment_params)
    @start_date = '2017-01-30'
  end

  def execute_request
    http_request(@url)
  end

  private

  def create_url(params)
    URI('https://redmine.renuo.ch/time_entries/report.csv?' + query(params) + api_key)
  end

  def api_key
    '&key=' + ENV['REDMINE_API_KEY']
  end

  def http_request(url)
    req = Net::HTTP::Get.new(url)

    Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
      http.request(req)
    end
  end

  def query(params = [])
    URI.encode_www_form([['utf8', '✓'], ['criteria[]', 'user'],
                         ['f[]', 'spent_on'], ['op[spent_on]', '>='], ['v[spent_on][]', @start_date],
                         ['f[]', ''],
                         ['c[]', 'project'], ['c[]', 'spent_on'], ['c[]', 'user'],
                         ['c[]', 'activity'], ['c[]', 'issue'], ['c[]', 'comments'],
                         ['c[]', 'hours'],
                         %w(columns month),
                         ['criteria[]', '']].push(*params))
  end
end
