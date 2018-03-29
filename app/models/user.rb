require 'twilio-ruby'

class User < ApplicationRecord
	has_many :accounts, as: :ownerable
	has_many :devices

	before_create :railsbank_onboard

	def railsbank_onboard
		@railsbank = Railsbank::Client.new(
		  api: Rails.application.secrets.railsbank_url,
		  access_token: Rails.application.secrets.railsbank_api_key
		)

		enduser = Railsbank::EndUser.new(type: 'person', name: self.name)
		self.enduser_id = @railsbank.end_users.create(enduser)
	end

	def send_notification(pid)
		return if self.mobile_number.blank?		
	    @twilio_client = Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token) 
	    @twilio_client.api.account.messages.create(
	      :from => Rails.application.secrets.twilio_phone_number,
	      :to => "+972 " + self.mobile_number.sub(/^0/, ""),
	      :body => "Hi, #{self.name}, please approve the purchase. https://iotpay.herokuapp.com/payments/notification/#{pid}"
	    )
  end

  def send_confirmation()
  	return if self.mobile_number.blank?
    @twilio_client = Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token) 
    @twilio_client.api.account.messages.create(
      :from => Rails.application.secrets.twilio_phone_number,
      :to => "+972 " + self.mobile_number.sub(/^0/, ""),
      :body => "Hello, #{self.name}, the payment was processed succesfully. Thank you for purchase."
    )
  end
end