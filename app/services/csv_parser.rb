class CsvParser
  require 'csv'

  def initialize(request)
    @csv_body = request.body
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
    @separated_csv_entries = CSV.parse(@csv_body, col_sep: ',')
  end

  def extract_keys
    @keys = @separated_csv_entries.shift
  end

  def convert_to_hashes
    @separated_csv_entries.map { |value| @keys.zip value }.map(&:to_h)
  end
end
