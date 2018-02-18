class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
    	t.string :pid
    	t.references :debit
    	t.references :credit
    	t.decimal :amount, precision: 15, scale: 2, default: 0.00
    	t.string :currency
    	t.string :reference
    	t.datetime :value_date, null: false
      t.timestamps
    end
  end
end
