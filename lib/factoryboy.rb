require "factoryboy/version"
require "factoryboy/value_extractor"
require "factoryboy/definition"

module Factoryboy
  class << self
    def define_factory(model, config = {}, &block)
      definitions[model] = Definition.new(model, config, block)
    end

    def build(id, attributes = {})
      instance = model_for(id).new
      attributes = default_attributes_for(id).merge(attributes)
      attributes.each { |key, value| instance.public_send("#{key}=", value) }
      instance
    end

    private

    def default_attributes_for(id)
      ValueExtractor.new(definitions[id].block).attributes if definitions.has_key?(id)
    end

    def model_for(id)
      definitions[id].class
    end

    def definitions
      @definitions ||= {}
    end
  end
end
