class Device < ApplicationRecord
	belongs_to :user
	has_many :contracts
	has_many :payments, as: :debitable
	has_many :payments, as: :creditable


	def has_waiting_contracts?(contract_type)
		(self.contracts.where(contract_type: contract_type).where(merchant_id: nil).count > 0) ? true : false
	end

	def image_url
		"https://iotpay.herokuapp.com/images/-#{self.device_type}.png"
	end

end
