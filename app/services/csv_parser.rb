class CsvParser
  require 'csv'

  def initialize(request)
    @csv_body = request.body
    @csv_entries = nil
    @keys = nil
  end

  def parse_to_hash
    parse_csv
    extract_keys
    convert_values_to_hashes
  end

  private

  def parse_csv
    @csv_entries = CSV.parse(@csv_body, col_sep: ',')
  end

  def extract_keys
    @keys = @csv_entries.shift
  end

  def convert_values_to_hashes
    @csv_entries.map { |value| @keys.zip value }.map(&:to_h)
  end
end
