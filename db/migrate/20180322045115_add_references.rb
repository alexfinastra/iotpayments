class AddReferences < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :enduser_id,  :string
  	add_column :merchants, :enduser_id,  :string
  	add_column :merchants, :beneficiary_id,  :string
  	add_column :accounts, :ledger_id,  :string
  end
end
