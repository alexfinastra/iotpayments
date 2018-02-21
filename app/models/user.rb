require 'twilio-ruby'
require 'sinatra'
require 'rubygems'

class User < ApplicationRecord
	has_many :accounts, as: :ownerable
	has_many :devices

	def send_notification()
    @twilio_client = Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token) 
    @twilio_client.api.account.messages.create(
      :from => Rails.application.secrets.twilio_phone_number,
      :to => "+972 " + self.mobile_number.sub(/^0/, ""),
      :body => "Hi, Whats up :)"
    )
  end
end

