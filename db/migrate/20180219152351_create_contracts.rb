class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
    	t.integer :device_id
    	t.integer :merchant_id
    	t.string :contract_type
    	t.string :description    	
    	t.decimal :amount
    	t.string :currency
      t.string :ethereum_reference
      t.integer :lifecycle
      t.timestamps
    end
  end
end
