class HashConcatenator
  def initialize(investment_entries, total_entries)
    @investment_entries = investment_entries
    @total_entries = total_entries
    @concatenated_hash = nil
  end

  def concatenate
    renamed_investment_entries = rename_keys(@investment_entries, 'worked_investment_hours')
    renamed_total_entries = rename_keys(@total_entries, 'worked_total_hours')
    concatenate_hashes(renamed_investment_entries, renamed_total_entries)
    change_values_to_number
  end

  private

  def rename_keys(entries, replacing_string)
    entries.each do |entry|
      entry['name'] = entry.delete('User').force_encoding('ISO-8859-1').encode('UTF-8')
      entry[replacing_string] = entry.delete('Total time')
    end
  end

  def concatenate_hashes(investment_entries, total_entries)
    @concatenated_hash = total_entries.each do |total_entry|
      investment_entries.each do |investment_entry|
        if total_entry['name'] == investment_entry['name']
          total_entry.merge!(investment_entry)
        end
      end
    end
  end

  def change_values_to_number
    @concatenated_hash.each do |entry|
      entry['worked_investment_hours'] = entry['worked_investment_hours'].to_f.round(2)
      entry['worked_total_hours'] = entry['worked_total_hours'].to_f.round(2)
    end
  end
end
