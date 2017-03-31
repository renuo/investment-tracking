class ConcatenateHashes
  def initialize(hash1, hash2)
    @hash1 = hash1
    @hash2 = hash2
    @new_hash
  end

  def concatenate
    @new_hash = (@hash1+@hash2).group_by{|h| h['user_id']}.map{|k,v| v.reduce(:merge)}

    @new_hash
    compare_with_older_entries
  end

  def compare_with_older_entries
    if User.all.empty?
      put_first_into_db
    else
      @new_hash.each do |entry|
        current_user = User.find_by(user_name: entry['name'])
        current_user_hours = current_user.open_investment_time
        if entry.key?('used_investment_time')
          newtime = entry['hours'] / 5 - entry['used_investment_time'] + current_user_hours
          if newtime > 80
            current_user.open_investment_time = 80
            current_user.save
          else
            current_user.open_investment_time = newtime
            current_user.save

          end
        else
          newtime = entry['hours'] / 5 + current_user_hours
          if newtime > 80
            current_user.open_investment_time = 80
            current_user.save

          else
            current_user.open_investment_time = newtime
            current_user.save

          end
        end
      end
    end

  end

  def put_first_into_db
    @new_hash.each do |entry|
      if entry.key?('used_investment_time') && entry['used_investment_time'] != nil
        user = User.new(:user_id => entry['user_id'], :user_name => entry['name'], :open_investment_time => (entry['hours'] / 5 - entry['used_investment_time']))
        user.save
      else
        user = User.new(:user_id => entry['user_id'], :user_name => entry['name'], :open_investment_time => entry['hours'] / 5)
        user.save
      end
    end

    time = Import.new(:latest_import => Time.now.to_s.sub(' ', 'T').split(' ')[0] + 'Z')
    time.save
  end
end

