def generate_sum_time(*time)
  pattern = /^([0-1]?[0-9]|2[0-3]):([0-5]?[0-9]):([0-5]?[0-9])$/
  total_sec = total_min = total_hr = 0
  0.upto(time.length - 1) do |index|
    if time[index] =~ pattern
      matched_pattern_time = pattern.match(time[index])
      total_sec = matched_pattern_time[3].to_i + total_sec.divmod(60)[1]
      total_min = matched_pattern_time[2].to_i + total_min.divmod(60)[1] + total_sec.divmod(60)[0] 
      total_hr = matched_pattern_time[1].to_i + total_hr + total_min.divmod(60)[0]
    else
      puts "Enter the valid value for time"
      return
    end
  end
  display_total_time(total_hr, total_min, total_sec)
end
def display_total_time(hours, minutes, seconds)
  print (hours.divmod(24)[0] == 0 ? "" : (hours.divmod(24)[0].to_s + " day & ") ) 
  puts (hours.divmod(24)[1]).to_s + " : " + (minutes.divmod(60)[1]).to_s + " : " + (seconds.divmod(60)[1]).to_s
end
generate_sum_time("11:23:07","22:53:45","0:23:23","23:45:56")