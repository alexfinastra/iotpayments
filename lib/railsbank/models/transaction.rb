module Railsbank
  # Transaction Model
  class Transaction < Base
    attribute :type
    attribute :ledger
    attribute :beneficiary
    #attribute :ledger_from
    #attribute :ledger_to
    attribute :payment_type, String
    attribute :amount, Float

    # Validations

    def type=(new_type)
      unless %w[inter-ledger out-ledger].index(new_type)
        ErrorMapping.fail_with(FailedCreate, { error: 'field', msg: 'Type most be [inter-ledger] or [out-ledger]' }.to_json)
      end
      super new_type
    end

    def ledger=(new_ledger)
      unless new_ledger.key?('ledger_id')
        ErrorMapping.fail_with(FailedCreate, { error: 'validation-ledger', msg: 'Ledger doesn\'t object' }.to_json)
      end
      super new_ledger
    end

    #def ledger_from=(new_ledger)
    #  unless new_ledger.key?('ledger_id')
    #    ErrorMapping.fail_with(FailedCreate, { error: 'validation-ledger', msg: 'Ledger doesn\'t object' }.to_json)
    #  end
    #  super new_ledger
    #end

    #def ledger_to=(new_ledger)
    #  unless new_ledger.key?('ledger_id')
    #    ErrorMapping.fail_with(FailedCreate, { error: 'validation-ledger', msg: 'Ledger doesn\'t object' }.to_json)
    #  end
    #  super new_ledger
    #end

    def beneficiary=(new_beneficiary)
      unless new_beneficiary.key?('beneficiary_id')
        ErrorMapping.fail_with(FailedCreate, { error: 'validation-beneficiary', msg: 'Beneficiary doesn\'t object' }.to_json)
      end
      super new_beneficiary
    end

    def payment_type=(new_payment_type)
      unless %w[payment-type-EU-SEPA-Step2 payment-type-EU-SEPA-Target2 payment-type-Global-SWIFT payment-type-UK-Chaps
                payment-type-UK-FasterPayments payment-type-UK-BACS payment-type-inter-ledger].index(new_payment_type)
        ErrorMapping.fail_with(FailedCreate, {
          error: 'validation-partner-product',
          msg: 'Allowed Values: payment-type-EU-SEPA-Step2, payment-type-EU-SEPA-Target2, payment-type-Global-SWIFT, payment-type-UK-Chaps,
                payment-type-UK-FasterPayments, payment-type-UK-BACS, payment-type-inter-ledger'
        }.to_json)
      end
      super new_payment_type
    end

    # Override to_hash
    def to_hash
      if type == 'out-legder'
        return {
          ledger_id: legder['ledger_id'],
          beneficiary_id: beneficiary['beneficiary_id'],
          payment_type: payment_type,
          amount: amount
        }
      end

      { ledger_from_id: legder_from['ledger_id'], ledger_to_id: legder_to['ledger_id'], amount: amount }
    end
  end
end
