# encoding: utf-8
class ProcessContractJob < ApplicationJob
  queue_as :default

  def perform(contract)
		Rails.logger.info(" Working with the contract #{contract.inspect}")
  	type = contract.device.device_type
  	return if type.blank?

  	merchants = Merchant.where(device_type: type).all
  	return if merchants.size.zero?

  	merchant = merchants[rand(0..merchants.size-1)]
  	contract.merchant = merchant
  	contract.save!
  end

end