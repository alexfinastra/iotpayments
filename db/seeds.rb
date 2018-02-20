# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'securerandom'

seed_size = 100

#users
users_arr = []
(1..seed_size).each do |i|
	users_arr.push({ 
		name: "user_#{i}", 
		mobile_number: nil, 
		address: "Local place #{i}", 
		city: "Locacity", 
		verification_code: SecureRandom.random_number(9999).to_s.rjust(4, '0'), 
		is_verified: false })
end
User.delete_all
users = User.create(users_arr)
puts "Users : #{users.size}" 

# devices
devices_arr = []
devices_types = ['coffe-machine', 'air-conditioner', 'tv', 'thermometer', 'car', 'washing-machine', 'fridge', 'solar', 'bulb', 'microvawe']
(1..seed_size).each do |i| 
	devices_types.each do |type|
		devices_arr.push({
			user: users[i-1], 
			serial_number: SecureRandom.uuid.to_s, 
			name: "device_#{type}_-#{SecureRandom.random_number(9999).to_s}" , 
			device_type: type, 
			description: "IoT #{type}"
			})
	end	
end
Device.delete_all
devices = Device.create(devices_arr)
puts "Devices : #{devices.size}" 

#merchants
merchants_size = 5
merchants_arr = []
devices_types.each do |type|
	(1..merchants_size).each do |i|
		merchants_arr.push({
			name: "merchant_#{type}_#{i}",
			device_type: type, 
			phone_number: "03-#{SecureRandom.random_number(999).to_s}-#{SecureRandom.random_number(9999).to_s}", 
			address: "Local place #{i}", 
			city: "Locacity"
		})
	end
end
Merchant.delete_all
merchants = Merchant.create(merchants_arr) 
puts "Merchants : #{merchants.size}" 

#accounts
accounts_arr = []
(1..seed_size).each do |i|
	accounts_arr.push({
    ownerable: users[i-1],
    number: SecureRandom.random_number(999999999).to_s,
    bank: "LOCAL",
    currency: "VTK"
   })
end	

(1..merchants.size).each do |i|
	accounts_arr.push({
    ownerable: merchants[i-1],
    number: SecureRandom.random_number(999999999).to_s,
    bank: "LOCAL",
    currency: "VTK"
   })
end
Account.delete_all
accounts = Account.create(accounts_arr) 
puts "Accounts : #{accounts.size}" 




