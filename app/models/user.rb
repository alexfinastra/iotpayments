class User < ApplicationRecord
	has_many :accounts, as: :ownerable
	has_many :devices
end
