class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
    	t.integer :user_id
    	t.string :serial_number
    	t.string :name
    	t.string :device_type
    	t.string :description
      t.timestamps
    end
  end
end
