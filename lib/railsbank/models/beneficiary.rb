module Railsbank
  # Beneficiary Model
  class Beneficiary < Base
    attribute :type, String
    attribute :name, String
    attribute :enduser
    attribute :asset_class, String
    attribute :asset_type, String
    attribute :person_or_company_payload, Hash, default: {}

    # Validations

    def type=(new_type)
      unless %w[company person].index(new_type)
        ErrorMapping.fail_with(FailedCreate, { error: 'field', msg: 'Type most be [person] or [company]' }.to_json)
      end
      super new_type
    end

    def enduser=(new_enduser)
      unless new_enduser.key?('enduser_id')
        ErrorMapping.fail_with(FailedCreate, { error: 'validation-enduser', msg: 'Enduser doesn\'t object' }.to_json)
      end
      super new_enduser
    end

    def asset_class=(new_asset_class)
      unless %w[currency commodity].index(new_asset_class)
        ErrorMapping.fail_with(FailedCreate, {
          error: 'validation-asset-class',
          msg: 'Allowed Values: currency, commodity'
        }.to_json)
      end
      super new_asset_class
    end

    def asset_type=(new_asset_type)
      unless %w[eur usd gbp gold whisky].index(new_asset_type)
        ErrorMapping.fail_with(FailedCreate, {
          error: 'validation-asset-type',
          msg: 'Allowed Values: eur, usd, gbp, gold, whisky'
        }.to_json)
      end
      super new_asset_type
    end

    # Override to_hash
    def to_hash
      data = Hash[type, { name: name }]
      data[type] = data[type].reverse_merge!(person_or_company_payload)
      data = data.reverse_merge!(holder_id: enduser['enduser_id'], asset_class: asset_class, asset_type: asset_type)
      data.reverse_merge!(payload)
    end
  end
end
