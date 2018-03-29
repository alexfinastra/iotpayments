require 'railsbank/version'
require 'active_support/all'
require 'resource_kit'
require 'kartograph'

# RailsBank module
module Railsbank
  # Client
  autoload :Client, 'railsbank/client'

  # Utils
  autoload :ErrorHandlingResourcable, 'railsbank/error_handling_resourcable'

  # Models
  autoload :Base, 'railsbank/models/base'
  autoload :EndUser, 'railsbank/models/end_user'
  autoload :Ledger, 'railsbank/models/ledger'
  autoload :Beneficiary, 'railsbank/models/beneficiary'
  autoload :Transaction, 'railsbank/models/transaction'

  # Resourcses
  autoload :EndUsersResource, 'railsbank/resources/end_users_resource'
  autoload :LedgersResource, 'railsbank/resources/ledgers_resource'
  autoload :BeneficiariesResource, 'railsbank/resources/beneficiaries_resource'
  autoload :TransactionsResource, 'railsbank/resources/transactions_resource'

  # Errors
  autoload :ErrorMapping, 'railsbank/mappings/error_mapping'
  Error = Class.new(StandardError)
  FailedCreate = Class.new(Railsbank::Error)
  FailedUpdate = Class.new(Railsbank::Error)
end
