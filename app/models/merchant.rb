class Merchant < ApplicationRecord
	has_many :accounts, as: :ownerable
	has_many :contracts
	has_many :payments, as: :debitable
	has_many :payments, as: :creditable

	#before_create :railsbank_onboard

	def railsbank_onboard
		@railsbank = Railsbank::Client.new(
		  api: Rails.application.secrets.railsbank_url,
		  access_token: Rails.application.secrets.railsbank_api_key
		)

		enduser = Railsbank::EndUser.new(type: 'company', name: self.name)
		self.enduser_id = @railsbank.end_users.create(enduser)

		beneficiary = Railsbank::Beneficiary.new(type: 'company', name: self.name , enduser: enduser, asset_class: 'currency', asset_type: 'eur')
		self.beneficiary_id = @railsbank.beneficiaries.create(beneficiary)
	end

end
