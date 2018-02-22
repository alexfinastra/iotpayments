class Contract < ApplicationRecord
	belongs_to :merchant, optional: true
	belongs_to :device, optional: true
	
	after_create_commit :process_contract
	after_update_commit :feed_payment

	def process_contract()		
		ProcessContractJob.set(wait: self.lifecycle.minute).perform_later(self)
	end

	def feed_payment()
		p = Payment.create!({
				pid: SecureRandom.hex.to_s,
        debitable: self.device,
      	creditable: self.merchant,
    		amount: self.amount,
    		currency: self.currency,
    		reference: self.ethereum_reference,
    	  value_date: Time.now,
      	message: Payment.pain001,
      	state: 'received'
			})

		sleep 5

		puts "Inspect payment after created : #{p.inspect}"
		if (device && device.user.mobile_number.black?)
			
		else
			p.notified!
		end
	end
end
