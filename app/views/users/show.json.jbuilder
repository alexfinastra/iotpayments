json.messages ['template'] do |t|
	json.attachment do
		json.type t
		json.payload do 
			json.template_type "generic"
			json.image_aspect_ratio "square"
			json.elements @devices do |d|
				json.partial! partial: 'devices/device', locals: { device: d }
			end
			json.elements json.partial! partial: 'devices/device', locals: { device: Device.new({name: "Add device", description: "Make a picture of code from the device" }) }
		end
	end
end


