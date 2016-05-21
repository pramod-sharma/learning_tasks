require 'json'
require 'date'

def convert_file_to_hash file_path
  string =  IO.read(file_path)
  hotel_details_hash = JSON.parse(string)
end

class SpecialSeason
  attr_reader :start, :end, :rate

  def initialize name, beginning, ending, rate
    @name = name
    @start = beginning
    @end = ending
    @rate = rate
  end

  def self.create_list( seasonal_details_array )
    list = []
    seasonal_details_array.each do |seasonal_details_hash|
      seasonal_details_hash.each do |season_name, season_details|
        name, beginning, ending, rate = season_name, season_details["start"], season_details["end"], season_details["rate"].to_i
        list.push SpecialSeason.new name, beginning, ending, rate 
      end
    end
    list
  end
end

class Hotel
  attr_reader :name, :rate, :tax, :seasons
  @@list = []

  def initialize name, rate, tax, seasonal_details_array
    @name = name
    @rate = rate
    @tax = tax
    if seasonal_details_array.is_a? Array
      @seasons = SpecialSeason.create_list seasonal_details_array
    end
    @@list.push self
  end

  def self.create_list hotels_hash
    hotels_hash.each do |hotel_details|
      name, rate, tax, seasonal_details_array = hotel_details["Hotel_name"], hotel_details["rate"].to_i, hotel_details["tax"].to_i, hotel_details["seasonal_rates"]
      Hotel.new name, rate, tax, seasonal_details_array
    end
  end

  def self.list
    @@list
  end

  def seasonal_rent checkin_date, checkout_date
    seasonal_rate, total_seasonal_days = 0, 0
    @seasons.each do |season|
      season_starting_date = Date.parse(season.start + "-" + (checkin_date.year.to_i - 1).to_s )
      season_end_date = Date.parse(season.end +  "-" + (checkin_date.year.to_i - 1).to_s)
      season_starting_date = season_starting_date << 12   if season_end_date < season_starting_date
      seasonal_days = 0
      while season_end_date.year <= checkout_date.year do
        # If checkin is before season start date and checout is after season end date
        if checkin_date <= season_starting_date && checkout_date >= season_end_date
          seasonal_days += ( season_end_date - season_starting_date + 1 ) 
        
        # If checkin is before season start date and checkout is before season end date
        elsif checkin_date <= season_starting_date && checkout_date <= season_end_date && checkout_date >= season_starting_date
          seasonal_days += ( checkout_date - season_starting_date + 1 ) 
        
        # If checkin is after season start date and checkout is after season end date
        elsif checkin_date >= season_starting_date && checkout_date >= season_end_date && checkin_date <= season_end_date
          seasonal_days += ( season_end_date - checkin_date + 1 ) 
        
        # If checkin is after season start date and checkout is before season end date
        elsif checkin_date >= season_starting_date && checkout_date <= season_end_date
          seasonal_days += ( checkout_date - checkin_date + 1 ) 
        
        end
        season_starting_date = season_starting_date >> 12 
        season_end_date = season_end_date >> 12
      end
      seasonal_rate += ( seasonal_days.to_i * season.rate )
      total_seasonal_days += seasonal_days.to_i 
    end
    return total_seasonal_days, seasonal_rate.to_i
  end

  def normal_rent normal_stay_period
    normal_stay_period * @rate
  end

end

class Reservation
  attr_reader :checkin_date, :checkout_date

  def initialize checkin_entered, checkout_entered
    @checkin_date = Date.parse(checkin_entered) 
    @checkout_date = Date.parse(checkout_entered)
  end

  def rent hotel
    total_stay = ( @checkout_date - @checkin_date + 1 ).to_i
    seasonal_stay_period, seasonal_period_rent = 0, 0 
    if hotel.seasons.is_a? Array
      seasonal_stay_period, seasonal_period_rent = hotel.seasonal_rent @checkin_date, @checkout_date
    end
    normal_stay_period = total_stay - seasonal_stay_period
    normal_period_rent = hotel.normal_rent normal_stay_period
    total_rate = normal_period_rent + seasonal_period_rent
    gross_total = total_rate + total_rate * hotel.tax / 100.0
    return normal_stay_period, normal_period_rent, seasonal_stay_period, seasonal_period_rent, gross_total 
  end
end

FILE_PATH = "hotels.json"
hotels_hash = convert_file_to_hash FILE_PATH
Hotel.create_list hotels_hash 

reservation = Reservation.new("25-12-2013","15-01-2014")
Hotel.list.each do |hotel|  
  puts hotel.name
  normal_stay_period, normal_period_rent, seasonal_stay_period, seasonal_period_rent, gross_total  = reservation.rent hotel
  puts "     Normal Stay period :  #{ normal_stay_period }  Normal Stay period rent :  #{ normal_stay_period.to_i * hotel.rate.to_i }"
  puts "     Seasonal Stay Period:   #{ seasonal_stay_period }   Seasonal Stay period rent :  #{ seasonal_period_rent }"
  puts "     Gross total(inclusive of tax) :     #{ gross_total }"
end
