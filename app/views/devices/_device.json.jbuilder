#json.extract! device, :id, :created_at, :updated_at
#json.url device_url(device, format: :json)

json.title device.name
if device.new_record?
	json.subtitle device.description
	json.image_url "https://iotpay.herokuapp.com/new_device.png"
	json.buttons ["add new"] do |title|
		json.type "web_url"
		json.url "/device/new" 
		json.title title
	end
else
	json.image_url device.image_url
	json.subtitle "Totaly payed: #{Payment.where(debitable_type: "Device", debitable_id: device.id).select("amount").all.inject(0.00){|sum, p| sum+=p.amount; sum}.to_s}"
	json.buttons ["more ..."] do |title|
		json.type "web_url"
		json.url device_url(device, format: :html) 
		json.title title
	end
end	

