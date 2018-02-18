class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :mobile_number
    	t.string :address
    	t.string :city
    	t.string :verification_code
    	t.boolean :is_verified
      t.timestamps
    end
  end
end
