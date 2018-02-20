class Merchant < ApplicationRecord
	has_many :accounts, as: :ownerable
	has_many :contracts
	has_many :payments, as: :debitable
	has_many :payments, as: :creditable
end
