require 'faraday'

module Railsbank
  # API client
  class Client
    attr_reader :api
    attr_reader :access_token

    def initialize(options = {})
      @access_token = options[:access_token]
      @api = options[:api]
    end

    def connection
      @faraday ||= Faraday.new connection_options do |req|
        req.adapter :net_http
      end
    end

    def self.resources
      {
        end_users: EndUsersResource,
        ledgers: LedgersResource,
        beneficiaries: BeneficiariesResource,
        transactions: TransactionsResource
      }
    end

    def method_missing(name, *args, &block)
      if self.class.resources.keys.include?(name)
        resources[name] ||=
          self.class.resources[name].new(connection: connection)
        resources[name]
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      super
    end

    def resources
      @resources ||= {}
    end

    private

    def connection_options
      {
        url: api,
        headers: {
          content_type: 'application/json',
          authorization: "API-Key #{access_token}"
        }
      }
    end
  end
end
