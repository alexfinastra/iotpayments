require 'creek'
namespace :upload do
  
  desc "upload users devices"
  task users_devices: :environment do

		workbook = Creek::Book.new './sample_excel_files/xlsx_500_rows.xlsx'
		worksheets = workbook.sheets
		puts "Found #{worksheets.count} worksheets"

		worksheets.each do |worksheet|
		  puts "Reading: #{worksheet.name}"
		  num_rows = 0

		  worksheet.rows.each do |row|
		    row_cells = row.values
		    num_rows += 1

		    # uncomment to print out row values
		    # puts row_cells.join " "

		    user = User.create!({ 
					name: XL.user_name, 
					mobile_number: XL.mobile_number, 
					address: "Local place #{i}", 
					city: "Locacity", 
					verification_code: SecureRandom.random_number(9999).to_s.rjust(4, '0'), 
					is_verified: true 
				})

		    device = Device.create!({
					user: user, 
					serial_number: SecureRandom.uuid.to_s, 
					name: XL.device_name, 
					device_type: XL.device_type, 
					description: XL.device_description
		   })

		  end
		  puts "Read #{num_rows} rows"
		end

  	
    

  	
  end

end




