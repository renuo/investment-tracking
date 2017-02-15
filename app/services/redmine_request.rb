class RedmineRequest
  def initialize(report_path)
    @url_report_path = report_path
    @url = create_url
  end

  def request_redmine_for_entries
    http_request
  end

  private

  def create_url
    URI(protocol + host + @url_report_path + query + key)
  end

  def protocol
    'https://'
  end

  def host
    'redmine.renuo.ch'
  end

  def hours_report_path
    '/time_entries/report.csv?'
  end

  def investment_report_path
    '/projects/renuo-investments/time_entries/report.csv?'
  end

  def query
    URI.encode_www_form([['utf8', '✓'],
                         ['f[]', 'spent_on'],
                         ['op[spent_on]', '>='],
                         ['v[spent_on][]', '2017-01-30'],
                         ['f[]', ''],
                         %w(columns month),
                         ['criteria[]', 'user']])
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
