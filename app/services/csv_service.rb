class CsvService
  def time_entries
    investment_params = RedmineRequestCsv::INVESTMENT_PARAMS
    investment_entries = get_entries_from_http_request(investment_params)
    total_entries = get_entries_from_http_request
    merged_entries = merge_entries(investment_entries, total_entries)
    sort_entries(merged_entries)
  end

  private

  def merge_entries(investment_entries, total_entries)
    total_entries.map do |total_entry|
      user_name_of_total_entry = total_entry['User']
      next if user_name_of_total_entry == 'Total time'
      investment_entry = investment_entries.find { |entry| user_name_of_total_entry == entry['User'] }
      investment_entry ||= { 'Total time' => 0 }
      { name: user_name_of_total_entry,
        worked_total_hours: total_entry['Total time'].to_f,
        worked_investment_hours: investment_entry['Total time'].to_f }.stringify_keys
    end.compact
  end

  def sort_entries(entries)
    entries.sort_by { |key| key['name'] }
  end

  def get_entries_from_http_request(params = [])
    http_response = http_request(params).execute_request
    encode_body_and_parse_to_hash(http_response)
  end

  def encode_body_and_parse_to_hash(http_response)
    encoded_body = http_response.body.force_encoding('ISO-8859-1').encode('UTF-8')
    CsvParser.new(encoded_body).parse_to_hash
  end

  def http_request(params)
    RedmineRequestCsv.new(params)
  end
end
