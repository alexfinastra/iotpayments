module Railsbank
  # Ledger Model
  class Ledger < Base
    attribute :enduser
    attribute :partner_product, String
    attribute :asset_class, String
    attribute :asset_type, String
    attribute :ledger_type, String
    attribute :ledger_who_owns_assets, String
    attribute :ledger_primary_use_types, Array[String]
    attribute :ledger_t_and_cs_country_of_jurisdiction, String

    # Validations

    def enduser=(new_enduser)
      unless new_enduser.key?('enduser_id')
        ErrorMapping.fail_with(FailedCreate, { error: 'validation-enduser', msg: 'Enduser doesn\'t object' }.to_json)
      end
      super new_enduser
    end

    def partner_product=(new_partner_product)
      unless %w[ExampleBank-EUR-1 ExampleBank-GBP-1].index(new_partner_product)
        ErrorMapping.fail_with(FailedCreate, {
          error: 'validation-partner-product',
          msg: 'Allowed Values: ExampleBank-EUR-1,ExampleBank-GBP-1'
        }.to_json)
      end
      super new_partner_product
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

    def ledger_type=(new_ledger_type)
      unless %w[ledger-type-single-user ledger-type-omnibus].index(new_ledger_type)
        ErrorMapping.fail_with(FailedCreate, {
          error: 'validation-ledger-type',
          msg: 'Allowed Values: ledger-type-single-user, ledger-type-omnibus'
        }.to_json)
      end
      super new_ledger_type
    end

    def ledger_who_owns_assets=(new_ledger_who_owns_assets)
      unless %w[ledger-assets-owned-by-me ledger-assets-owned-by-other].index(new_ledger_who_owns_assets)
        ErrorMapping.fail_with(FailedCreate, {
          error: 'validation-ledger-who-owns-assets',
          msg: 'Allowed Values: ledger-assets-owned-by-me, ledger-assets-owned-by-other'
        }.to_json)
      end
      super new_ledger_who_owns_assets
    end

    def ledger_primary_use_types=(new_ledger_primary_use_types)
      unless new_ledger_primary_use_types.is_a?(Array)
        ErrorMapping.fail_with(FailedCreate, {
          error: 'validation-is-array',
          msg: 'most be Array[String]'
        }.to_json)
      end
      super new_ledger_primary_use_types
    end

    # Override to_hash
    def to_hash
      {
        holder_id: enduser['enduser_id'],
        partner_product: partner_product,
        asset_class: asset_class,
        asset_type: asset_type,
        ledger_type: ledger_type,
        ledger_who_owns_assets: ledger_who_owns_assets,
        ledger_primary_use_types: ledger_primary_use_types,
        ledger_t_and_cs_country_of_jurisdiction: ledger_t_and_cs_country_of_jurisdiction
      }
    end
  end
end
