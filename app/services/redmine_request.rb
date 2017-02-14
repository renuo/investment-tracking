class RedmineRequest
  def retrieve_investment_time
    http_request(create_uri_investment_time)
  end

  def retrieve_time_entries
    http_request(create_uri_time_entries)
  end

  private

  def create_uri_time_entries
    URI(protocol + host + hours_report_path + query + key)
  end

  def create_uri_investment_time
    URI(protocol + host + investment_report_path + query + key)
  end

  def protocol
    'https://'
  end

  def host
    'redmine.renuo.ch'
  end

  def hours_report_path
    '/time_entries/report.csv'
  end

  def investment_report_path
    '/projects/renuo-investments/time_entries/report.csv'
  end

  def query
    '?utf8=%E2%9C%93&
f%5B%5D=spent_on&
op%5Bspent_on%5D=%3E%3D&
v%5Bspent_on%5D%5B%5D=2017-01-30&
f%5B%5D=&
columns=month&
criteria%5B%5D=user&'
  end

  def key
    'key=' + ENV['REDMINE_API_KEY']
  end

  def http_request(url)
    req = Net::HTTP::Get.new(url)

    Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
      http.request(req)
    end
  end
end
