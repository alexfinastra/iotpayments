namespace :payment do
  
  desc "schedule payments generation"
  task schedule: :environment do
  	contract_types_by_device_types = {
			'coffe-machine' => [['warranty', 100.00, 60],['subscription', 5.00, 10],['maintenance', 20, 30]], 
			'air-conditioner'=> [['warranty', 120.00, 60],['maintenance', 70.00, 30]],  
			'tv'=> [['warranty', 80.00, 60],['subscription', 1.00, 30]],  
			'thermometer'=> [['warranty', 20.00, 60]],  
			'car'=> [['warranty', 200.00, 60],['subscription', 20.00, 10],['maintenance', 90.00, 30]],  
			'washing-machine'=> [['warranty', 100.00, 60],['subscription', 5.00, 30],['maintenance', 20.00, 30]],  
			'fridge'=> [['warranty', 120.00, 60],['subscription', 60.00, 10],['maintenance', 20.00, 30]],  
			'solar'=> [['warranty', 300.00, 60],['maintenance', 170.00,30]],  
			'bulb'=> [['warranty', 10.00, 60]],  
			'microvawe'=> [['warranty', 40.00, 60],['maintenance', 10.00, 30]]
		}
  	
    User.where(is_verified: true).all.each do |user|
  		user.devices.each do |device|  	
				contract_types_by_device_types[device.device_type].each do |c|					
					puts "setup for is #{c.inspect}"
					next if device.has_waiting_contracts?(c[0])	
					
					Contract.create!({						
						contract_type: c[0],
						device: device,
						description: "Contract for #{device.name} of #{c[0]} type, signed at #{Time.now.to_s(:long)}",
						ethereum_reference: SecureRandom.hex.to_s,
						amount: c[1],
						currency: "VTK",
						lifecycle: rand(0..3) 
					})				
				end
  		end
  	end
  end

end
