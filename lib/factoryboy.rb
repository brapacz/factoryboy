require "factoryboy/version"

module Factoryboy
  class << self
    def define_factory(model)
    end
    
    def build(model, attributes = {})
      model.new.tap do |instance|
        attributes.each { |key, value| instance.public_send("#{key}=", value) }
      end
    end
  end
end
