module Railsbank
  # Enduser Model
  class EndUser < Base
    attribute :type, String
    attribute :name, String

    def type=(new_type)
      unless %w[company person].index(new_type)
        ErrorMapping.fail_with(FailedCreate, { error: 'field', msg: 'Type most be [person] or [company]' }.to_json)
      end
      super new_type
    end

    def to_hash
      data = Hash[type, { name: name }]
      data[type] = data[type].reverse_merge!(payload)
      data
    end
  end
end
