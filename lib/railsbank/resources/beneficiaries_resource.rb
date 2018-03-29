module Railsbank
  # beneficiaries resource class
  # access from client.beneficiaries.{function_name}
  class BeneficiariesResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do
      # create new Legder and assign
      # client.beneficiaries.create(beneficiary)
      action :create, 'POST /v1/customer/beneficiaries' do
        body { |object| object.to_json }
        handler(200) { |response| JSON.parse(response.body)['beneficiary_id'] }
        handler(400) { |response| ErrorMapping.fail_with(FailedCreate, response.body) }
      end

      # update Beneficiary
      # client.beneficiaries.update(beneficiary_id: uuid, beneficiary: model)
      action :update, 'PUT /v1/customer/beneficiaries/:beneficiary_id' do
        body { |object| object[:enduser].to_json }
        handler(200) { |response| JSON.parse(response.body)['beneficiary_id'] }
        handler(400) { |response| ErrorMapping.fail_with(FailedCreate, response.body) }
      end

      # find Beneficiary
      # client.legders.find(beneficiary_id: uuid)
      action :find, 'GET /v1/customer/beneficiaries/:beneficiary_id' do
        handler(200) { |response| JSON.parse(response.body) }
      end

      # find in wait Beneficiary
      # client.legders.find_wait(beneficiary_id: uuid)
      action :find_wait, 'GET /v1/customer/beneficiaries/:beneficiary_id/wait' do
        handler(200) { |response| JSON.parse(response.body) }
      end
    end
  end
end
