module Railsbank
  class ErrorMapping
    Error = Struct.new(:error, :msg)

    include Kartograph::DSL

    kartograph do
      mapping Error

      property :error, scopes: [:read]
      property :msg, scopes: [:read]
    end

    def self.fail_with(klass, content)
      error = extract_single(content, :read)
      raise klass, error
    end
  end
end