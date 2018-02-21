require 'creek'
namespace :upload do
  
  desc "upload users devices"
  task users_devices: :environment do

		workbook = Creek::Book.new "#{Rails.root}/lib/tasks/iotideas.xlsx"
		worksheets = workbook.sheets
		puts "Found #{worksheets.count} worksheets"

		worksheets.each do |worksheet|
		  puts "Reading: #{worksheet.name}"
		  num_rows = 0

		  worksheet.rows.each do |row|
		    row_cells = row.values
		    num_rows += 1
		    next if num_rows == 1

		    data = {
		    	name: row_cells[0],
		    	mobile_number: row_cells[1],
		    	device_name: row_cells[2],
		    	device_type: row_cells[3],
		    	device_description: row_cells[4]
		    }
		    # uncomment to print out row values
		    puts data.inspect
		    
		    user = User.where(mobile_number: data[:mobile_number]).where(is_verified: true).first
		    if(user.blank?)
		    	user = User.create!({ 
						name: data[:name], 
						mobile_number: data[:mobile_number], 
						address: "Local place #{i}", 
						city: "Locacity", 
						verification_code: SecureRandom.random_number(9999).to_s.rjust(4, '0'), 
						is_verified: true 
					})
		    end
		    
		    if(user.devices.where(name: data[:device_name]).where(device_type: data[:device_type]).count == 0)
		    	 device = Device.create!({
							user: user, 
							serial_number: SecureRandom.uuid.to_s, 
							name: data[:device_name], 
							device_type: data[:device_type], 
							description: data[:device_description]
				   })
		    end

		  end
		  puts "Read #{num_rows} rows"
		end  	
  end

end




