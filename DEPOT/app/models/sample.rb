class Sample < ActiveRecord::Base
	validates :phone, numericality: { greater_than_or_equal_to: 0 }
end