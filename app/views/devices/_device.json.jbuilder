#json.extract! device, :id, :created_at, :updated_at
#json.url device_url(device, format: :json)

json.title device.name
json.image_url device.image_url
json.subtitle device.description
json.buttons ["View Device"] do |title|
	json.type "web_url"
	json.url device_url(device, format: :json)
	json.title title
end
