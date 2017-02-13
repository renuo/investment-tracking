class RedmineRequest
  def login
    response = perform_request
    response2 = perform_request2
    response3 = perform_request3
    if response.code == '200'
      json_response = JSON.parse(response.body)
      json_response2 = JSON.parse(response2.body)
      json_response3 = JSON.parse(response3.body)
      { status: :ok, api_key: json_response['time_entries'] + json_response2['time_entries'] + json_response3['time_entries'] }
    else
      { status: :unauthorized }
    end
  end

  def perform_request
    uri = URI('https://redmine.renuo.ch/time_entries.json?key=' + ENV['REDMINE_API_KEY'] + '&limit=100')
    req = Net::HTTP::Get.new(uri)

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
  end

  def perform_request2
    uri = URI('https://redmine.renuo.ch/time_entries.json?key=' + ENV['REDMINE_API_KEY'] + '&limit=100&offset=100')
    req = Net::HTTP::Get.new(uri)

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
  end

  def perform_request3
    uri = URI('https://redmine.renuo.ch/time_entries.json?key=' + ENV['REDMINE_API_KEY'] + '&limit=100&offset=200')
    req = Net::HTTP::Get.new(uri)

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
  end
end
