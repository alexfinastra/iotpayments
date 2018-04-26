# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'securerandom'

seed_size = 20

#users
users_arr = []
users_arr.push({
		name: "Alex", 
		mobile_number: '0526116531', 
		address: "Novotel Paddington", 
		city: "London", 
		verification_code: SecureRandom.random_number(9999).to_s.rjust(4, '0'), 
		is_verified: false
	})
(2..seed_size).each do |i|
	users_arr.push({ 
		name: "User #{i}", 
		mobile_number: nil, 
		address: "Central Street #{i}", 
		city: "London", 
		verification_code: SecureRandom.random_number(9999).to_s.rjust(4, '0'), 
		is_verified: false })
end

#User.delete_all
users = User.create(users_arr)
puts "Users : #{users.size}" 

# devices
devices_arr = []
devices_types = ['coffee-machine', 'air-conditioner', 'tv', 'thermometer', 'car', 'washing-machine', 'fridge', 'solar', 'bulb', 'microvawe']
(2..seed_size).each do |i| 
	devices_types.each do |type|
		devices_arr.push({
			user: users[i-1], 
			serial_number: SecureRandom.uuid.to_s, 
			name: "#{type} #{SecureRandom.random_number(9999).to_s}" , 
			device_type: type, 
			description: "IoT #{type} for human usage"
			})
	end	
end
#Device.delete_all
devices_arr.push({
		  user: User.where(mobile_number: '0526116531').first, 
			serial_number: SecureRandom.uuid.to_s, 
			name: "Amazon dash button" , 
			device_type: 'iotbutton', 
			description: "Amazon dash button for you"
	})
devices_arr.push({
		  user: User.where(mobile_number: '0526116531').first, 
			serial_number: SecureRandom.uuid.to_s, 
			name: "Finastra ID" , 
			device_type: 'pay', 
			description: "Finastra Central Id for payments by account"
	})
devices = Device.create(devices_arr)
puts "Devices : #{devices.size}" 

#merchants
merchants_size = 5
merchants_arr = []
devices_types.each do |type|
	(1..merchants_size).each do |i|
		merchants_arr.push({
			name: "Merchant #{type} #{i}",
			device_type: type, 
			phone_number: "03-#{SecureRandom.random_number(999).to_s}-#{SecureRandom.random_number(9999).to_s}", 
			address: "Any valid street #{i}", 
			city: "London"
		})
	end
end
Merchant.delete_all
merchants_arr.push({
		name: "IoT dash button",
		device_type: 'iotbutton', 
		phone_number: "03-#{SecureRandom.random_number(999).to_s}-#{SecureRandom.random_number(9999).to_s}", 
		address: "Local place on Amazon", 
		city: "Locacity"
	})
merchants_arr.push({
		name: "Ecommerce online merchant",
		device_type: 'pay', 
		phone_number: "03-#{SecureRandom.random_number(999).to_s}-#{SecureRandom.random_number(9999).to_s}", 
		address: "Ecommerce Merchant", 
		city: "Locacity"
	})
merchants = Merchant.create(merchants_arr) 
puts "Merchants : #{merchants.size}" 

#accounts
accounts_arr = []
(1..seed_size).each do |i|
	accounts_arr.push({
    ownerable: users[i-1],
    number: SecureRandom.random_number(999999999).to_s,
    bank: "Railsbank",
    currency: "GBP"
   })
end	

(1..merchants.size).each do |i|
	accounts_arr.push({
    ownerable: merchants[i-1],
    number: SecureRandom.random_number(999999999).to_s,
    bank: "Railsbank",
    currency: "GBP"
   })
end
Account.delete_all
accounts = Account.create(accounts_arr) 
puts "Accounts : #{accounts.size}" 




