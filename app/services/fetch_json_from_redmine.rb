class FetchJsonFromRedmine
  def initialize
    @new_entries = 0
    @offset = 0
    @json_body = nil
  end

  def fetch_json_from_redmine
    http_request(@offset)
    add_new_entries_do_db
    if @new_entries === 100 && @offset < 5
      # puts 'hier drinn'
      @new_entries = 0
      @offset += 1
      fetch_json_from_redmine
    end
  end

  private

  def http_request(offset)
    uri = URI('https://redmine.renuo.ch/time_entries.json?limit=100&offset=' + (offset * 100).to_s)
    params = { key: 'edceedbd8b008fb17be6d0de9f125f35cebba643' }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    body = res.body

    @json_body = JSON.parse(body)['time_entries']
  end

  def add_new_entries_do_db
    @json_body.map do |line|
      if TimesPerUser.exists?(ticketId: line['id'])
        # puts 'schon drinn'
      else
        user = TimesPerUser.new
        # puts 'do not exist till now'
        user.name = line['user']['id']
        user.ticketId = line['id']
        user.workedTimes = line['hours']
        user.save
        @new_entries += 1
      end
    end
    # puts @new_entries
  end
end
