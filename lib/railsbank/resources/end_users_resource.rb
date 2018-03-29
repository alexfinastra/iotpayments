module Railsbank
  # endUser resource class
  # access from client.end_users.{function_name}
  class EndUsersResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do
      # create new User
      # client.end_users.create(end_user)
      action :create, 'POST /v1/customer/endusers' do
        body { |object| object.to_json }
        handler(200) { |response| JSON.parse(response.body)['enduser_id'] }
        handler(400) { |response| ErrorMapping.fail_with(FailedCreate, response.body) }
      end

      # update User
      # client.end_users.update(enduser_id: uuid, enduser: model)
      action :update, 'PUT /v1/customer/endusers/:enduser_id' do
        body { |object| object[:enduser].to_json }
        handler(200) { |response| JSON.parse(response.body)['enduser_id'] }
        handler(400) { |response| ErrorMapping.fail_with(FailedCreate, response.body) }
      end

      # find all User
      # client.end_users.all
      action :all, 'GET /v1/customer/endusers' do
        handler(200) { |response| JSON.parse(response.body) }
      end

      # find User
      # client.end_users.find(enduser_id: uuid)
      action :find, 'GET /v1/customer/endusers/:enduser_id' do
        handler(200) { |response| JSON.parse(response.body) }
      end

      # find enduser kyc doc
      # client.end_users.find_kyc_documents
      action :find_kyc_documents, 'GET /v1/customer/endusers/:enduser_id/documents' do
        handler(200) { |response| JSON.parse(response.body) }
      end

      # find in wait User
      # client.end_users.find_wait(enduser_id: uuid)
      action :find_wait, 'GET /v1/customer/endusers/:enduser_id/wait' do
        handler(200) { |response| JSON.parse(response.body) }
      end
    end
  end
end
