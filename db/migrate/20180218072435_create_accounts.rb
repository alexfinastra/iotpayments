class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
    	t.integer :owner_id
    	t.string :number
    	t.string :type
    	t.string :bank
    	t.decimal :balance, precision: 15, scale: 2, default: 0.00
    	t.string :currency
      t.timestamps
    end
  end
end
