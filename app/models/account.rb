class Account < ApplicationRecord
	belongs_to :ownerable, polymorphic: true
	
  def update_balance!(amount)
  	self.balance = self.balance = amount
  	save!
  end

  before_create :railsbank_onboard

	def railsbank_onboard
		return if ownerable.blank?

		@railsbank = Railsbank::Client.new(
		  api: Rails.application.secrets.railsbank_url,
		  access_token: Rails.application.secrets.railsbank_api_key
		)

		enduser = @railsbank.end_users.find(enduser_id: ownerable.enduser_id)

		ledger = Railsbank::Ledger.new(
		  enduser: enduser,
		  partner_product: 'ExampleBank-EUR-1',
		  asset_class: 'currency',
		  asset_type: 'eur',
		  ledger_type: 'ledger-type-single-user',
		  ledger_who_owns_assets: 'ledger-assets-owned-by-me',
		  ledger_primary_use_types: ['ledger-primary-use-types-payments'],
		  ledger_t_and_cs_country_of_jurisdiction: 'GB'
		)		
		self.ledger_id = @railsbank.ledgers.create(ledger)
	end
end
