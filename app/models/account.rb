class Account < ApplicationRecord
	belongs_to :user
	belongs_to :merchant
	has_many :debit_payments, :class_name => 'Payment', :foreign_key => 'debit_id'
  has_many :credit_payments, :class_name => 'Payment', :foreign_key => 'credit_id'

end
