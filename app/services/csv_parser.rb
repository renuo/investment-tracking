class CsvParser
  require 'csv'

  def parse_to_hash(time_entries)
    parse_from_csv_to_hash(time_entries)
  end

  private

  def parse_from_csv_to_hash(time_entries)
    csv = CSV.parse(time_entries.body, col_sep: ';')
    key = csv.first
    values = csv[1..-1]
    values.map { |value| key.zip value }.map(&:to_h)
  end
end
