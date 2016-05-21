def sum_time(time1, time2)
  time1_array, time2_array = match_time_pattern(time1, time2)
  total_sec = time1_array[3].to_i + time2_array[3].to_i
  total_min = time1_array[2].to_i + time2_array[2].to_i + total_sec / 60
  total_hr = time1_array[1].to_i + time2_array[1].to_i + total_min / 60
  display_total_time(total_hr, total_min, total_sec)
end

def match_time_pattern time1, time2
  time_pattern = /^([0-1]?[0-9]|2[0-3]):([0-5]?[0-9]):([0-5]?[0-9])$/
  if (time1 =~ time_pattern && time2 =~ time_pattern)
    matched_pattern_time1 = time_pattern.match(time1)
    matched_pattern_time2 = time_pattern.match(time2)
    return matched_pattern_time1, matched_pattern_time2
  else
    puts "enter valid time values"
    exit
  end
end

def display_total_time(hours ,minutes, seconds)
  print (hours.divmod(24)[0] == 0 ? "" : (hours.divmod(24)[0].to_s + " day & ") ) 
  puts (hours.divmod(24)[1]).to_s + " : " + (minutes.divmod(60)[1]).to_s + " : " + (seconds.divmod(60)[1]).to_s
end

sum_time("24:34:56","15:45:45")