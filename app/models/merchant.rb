class Merchant < ApplicationRecord
	has_many :accounts
	has_many :contracts
	
end
