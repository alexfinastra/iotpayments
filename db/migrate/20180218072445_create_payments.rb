class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
    	t.string :pid
      t.references :debitable, polymorphic: true, index: true
      t.references :creditable, polymorphic: true, index: true
    	t.decimal :amount, precision: 15, scale: 2, default: 0.00
    	t.string :currency
    	t.string :reference
    	t.datetime :value_date, null: false
      t.xml :message
      t.timestamps
    end
  end
end
