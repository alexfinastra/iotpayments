require 'virtus'

module Railsbank
  # Base model
  class Base
    include Virtus.model
    include Virtus::Equalizer.new(name || inspect)
    include Virtus.model(constructor: true, mass_assignment: true)

    attribute :payload, Hash, default: {}

    def inspect
      values = Hash[instance_variables.map { |name| [name, instance_variable_get(name)] }]
      "<#{self.class.name} #{values}>"
    end
  end
end
