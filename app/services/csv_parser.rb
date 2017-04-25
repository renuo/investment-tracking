class CsvParser
  require 'csv'

  PARSER_ERROR_MESSAGE = 'Malformed CSV, please use comma delimiters (Redmine language setting?)'.freeze

  def initialize(request)
    @csv_body = request.body
    @separated_csv_entries = nil
    @keys = nil
  end

  def parse_to_hash
    separate_csv
    extract_keys
    convert_to_hashes
    encode_user_name
  end

  private

  def separate_csv
    @separated_csv_entries = CSV.parse(@csv_body, col_sep: ',')
  rescue CSV::MalformedCSVError
    raise PARSER_ERROR_MESSAGE
  end

  def extract_keys
    @keys = @separated_csv_entries.shift
  end

  def convert_to_hashes
    @separated_csv_entries = @separated_csv_entries.map { |value| @keys.zip value }.map(&:to_h)
  end

  def encode_user_name
    @separated_csv_entries.each do |entry|
      entry['User'] = entry['User'].force_encoding('ISO-8859-1').encode('UTF-8')
    end
  end
end
