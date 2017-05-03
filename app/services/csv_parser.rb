class CsvParser
  require 'csv'

  PARSER_ERROR_MESSAGE = 'Malformed CSV, please use comma delimiters (Redmine language setting?)'.freeze

  def initialize(body)
    @response_body = body
    @separated_csv_entries = nil
    @keys = nil
  end

  def parse_to_hash
    separate_csv
    extract_keys
    convert_to_hashes
  end

  private

  def separate_csv
    @separated_csv_entries = CSV.parse(@response_body, col_sep: ',')
  rescue CSV::MalformedCSVError
    raise PARSER_ERROR_MESSAGE
  end

  def extract_keys
    @keys = @separated_csv_entries.shift
  end

  def convert_to_hashes
    @separated_csv_entries = @separated_csv_entries.map { |value| @keys.zip value }.map(&:to_h)
  end
end
