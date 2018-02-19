class Contract < ApplicationRecord
	belongs_to :merchant
	belongs_to :device
	 
end
