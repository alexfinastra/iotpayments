module Railsbank
  # ledgers resource class
  # access from client.ledgers.{function_name}
  class LedgersResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do
      # create new Legder and assign
      # client.ledgers.create(ledgers)
      action :create, 'POST /v1/customer/ledgers' do
        body { |object| object.to_json }
        handler(200) { |response| JSON.parse(response.body)['ledger_id'] }
        handler(400) { |response| ErrorMapping.fail_with(FailedCreate, response.body) }
      end

      # find all unassigned ledgers
      # client.ledgers.all_unassigned
      action :all_unassigned, 'GET /v1/customer/unassigned/ledgers' do
        handler(200) { |response| JSON.parse(response.body) }
      end

      # find all ledgers
      # client.ledgers.all
      action :all, 'GET /v1/customer/me/ledgers' do
        handler(200) { |response| JSON.parse(response.body) }
      end

      # find Legder
      # client.ledgers.find(ledgers_id: uuid)
      action :find, 'GET /v1/customer/ledgers/:ledgers_id' do
        handler(200) { |response| JSON.parse(response.body) }
      end

      # find in wait ledgers
      # client.ledgers.find_wait(ledgers_id: uuid)
      action :find_wait, 'GET /v1/customer/ledgers/:ledgers_id/wait' do
        handler(200) { |response| JSON.parse(response.body) }
      end

      # Assign IBAN to leger
      # client.ledgers.assign_iban(ledgers_id: uuid)
      action :assign_iban, 'POST /v1/customer/ledgers/:ledgers_id/assign-iban' do
        handler(200) { |response| JSON.parse(response.body)['ledger_id'] }
        handler(400) { |response| ErrorMapping.fail_with(FailedCreate, response.body) }
      end
    end
  end
end
