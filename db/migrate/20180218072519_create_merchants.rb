class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
    	t.string :name
    	t.string :phone_number
    	t.string :address
    	t.string :city
      t.timestamps
    end
  end
end
