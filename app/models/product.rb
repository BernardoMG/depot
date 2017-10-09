class Product < ApplicationRecord
	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	#  Because the database stores just two digits after the decimal point, this would end up being zero in the database >= 0.01
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: { 
		with: %r{\.(gif|jpg|png)\Z}i, 
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
	validates :title, length: {minimum: 10, too_short: 'Title must be at least 10 characters.'}
end
