class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
    	t.integer :device_id
    	t.integer :merchant_id
    	t.string :name
    	t.string :group
    	t.string :description
    	t.string :ethereum_reference
    	t.string :period
    	t.decimal :amount
    	t.string :currency
      t.timestamps
    end
  end
end
