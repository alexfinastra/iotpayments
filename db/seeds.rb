# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'securerandom'

seed_size = 50

#users
users_arr = []
(0..seed_size).each do |i|
	users_arr.push({ 
		name: "user_#{i}", 
		mobile_number: nil, 
		address: "Local place #{i}", 
		city: "Locacity", 
		verification_code: SecureRandom.random_number(9999).to_s.rjust(4, '0'), 
		is_verified: false })
end
users = User.create(users_arr)
puts "Users : #{users.size}" 

# devices
devices_arr = []
devices_types = ['coffe-machine', 'air-conditioner', 'tv', 'thermometer', 'car', 'washing-machine', 'fridge', 'solar', 'bulb', 'microvawe']
(0..seed_size).each do |i| 
	devices_types.each do |type|
		devices_arr.push({
			user: users[i], 
			serial_number: SecureRandom.uuid.to_s, 
			name: "device_#{type}_-#{SecureRandom.random_number(9999).to_s}" , 
			group: type, 
			description: "IoT #{type}"
			})
	end	
end
devices = Device.create(devices_arr)
puts "Devices : #{devices.size}" 

#merchants
merchants_size = 5
merchants_arr = []
devices_types.each do |type|
	(0..merchants_size).each do |i|
		merchants_arr.push({
			name: "merchant_#{type}_#{i}",
			group: type, 
			phone_number: "03-#{SecureRandom.random_number(999).to_s}-#{SecureRandom.random_number(9999).to_s}", 
			address: "Local place #{i}", 
			city: "Locacity"
		})
	end
end
merchants = Merchant.create(merchants_arr) 
puts "Merchants : #{merchants.size}" 

#accounts
accounts_arr = []
(0..seed_size).each do |i|
	accounts_arr.push({
    owner_id: users[i].id,
    number: SecureRandom.random_number(999999999).to_s,
    bank: "LOCAL",
    currency: "VTK"
   })
end	

(0..merchants.size-1).each do |i|
	accounts_arr.push({
    owner_id: merchants[i].id,
    number: SecureRandom.random_number(999999999).to_s,
    bank: "LOCAL",
    currency: "VTK"
   })
end
accounts = Account.create(accounts_arr) 
puts "Accounts : #{accounts.size}" 

#contracts
contracts_arr = []
devices_types_hash = {
	'coffe-machine' => [['warranty', 100.00, 60],['subscription', 5.00, 10],['maintenance', 20, 30]], 
	'air-conditioner'=> [['warranty', 120.00, 60],['maintenance', 70, 30]],  
	'tv'=> [['warranty', 80.00, 60],['subscription', 1.00, 30]],  
	'thermometer'=> [['warranty', 20.00, 60]],  
	'car'=> [['warranty', 200.00, 60],['subscription', 20.00, 10],['maintenance', 90, 30]],  
	'washing-machine'=> [['warranty', 100.00, 60],['subscription', 5.00, 30],['maintenance', 20, 30]],  
	'fridge'=> [['warranty', 120.00, 60],['subscription', 60.00, 10],['maintenance', 20, 30]],  
	'solar'=> [['warranty', 300.00, 60],['maintenance', 170,30]],  
	'bulb'=> [['warranty', 10.00, 60]],  
	'microvawe'=> [['warranty', 40.00, 60],['maintenance', 10, 30]]
}

(0..devices.size-1).each do |i|	
	type = devices[i].group
	devices_types_hash[type].each do |c|
		contracts_arr.push({
				device: devices[i],
				merchant: merchants.select{|m| m.group == type}[rand(0..9)],
				name: c[0],
				group: type,
				description: "Contract_#{type}_#{c[0]}_#{i}",
				ethereum_reference: SecureRandom.hex.to_s,
				period: c[2],
				amount: c[1],
				currency: "VTK" 
			})
	end
end

contracts = Contract.create(contracts_arr) 
puts "Contracts : #{contracts.size}" 



