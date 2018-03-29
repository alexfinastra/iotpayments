module Railsbank
  # Transactions resource class
  # access from client.transactions.{function_name}
  class TransactionsResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do
      # create new out_ledger transaction
      # client.ledgers.create_out_ledger(ledgers)
      action :create_out_ledger, 'POST /v1/customer/transactions' do
        body { |object| object.to_json }
        handler(200) { |response| JSON.parse(response.body)['transaction_id'] }
        handler(400) { |response| ErrorMapping.fail_with(FailedCreate, response.body) }
      end

      # create new inter_ledger transaction
      # client.ledgers.create_inter_ledger(ledgers)
      action :create_inter_ledger, 'POST /v1/customer/transactions/inter-ledger' do
        body { |object| object.to_json }
        handler(200) { |response| JSON.parse(response.body)['transaction_id'] }
        handler(400) { |response| ErrorMapping.fail_with(FailedCreate, response.body) }
      end

      # find all transactions
      # client.transactions.all
      action :all, 'GET /v1/customer/transactions' do
        handler(200) { |response| JSON.parse(response.body) }
      end

      # rerun firewal
      # client.ledgers.all
      action :rerun_firewall, 'POST /customer/transactions/:transaction_id/rerun-firewall' do
        handler(200) { |response| JSON.parse(response.body)['transaction_id'] }
      end

      # find transaction
      # client.transactions.find(transaction_id: uuid)
      action :find, 'GET /v1/customer/transactions/:transaction_id' do
        handler(200) { |response| JSON.parse(response.body) }
      end
    end
  end
end
