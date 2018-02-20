class Account < ApplicationRecord
	belongs_to :ownerable, polymorphic: true
	
  def update_balance!(amount)
  	self.balance = self.balance = amount
  	save!
  end
end
