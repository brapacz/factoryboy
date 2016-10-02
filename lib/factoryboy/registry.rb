module Factoryboy
  class Registry
    def define_factory(model, config = {}, &block)
      definitions[model] = Definition.new(model, config, block)
    end

    def build(id, custom_attributes = {})
      assing_attributes_to create(id), default_attributes_for(id).merge(custom_attributes)
    end

    private

    def assing_attributes_to(object, attributes)
      attributes.each { |key, value| object.public_send("#{key}=", value) }
      object
    end

    def find(id)
      raise MissingDefinitionError.new(id) unless definitions.has_key?(id)
      definitions[id]
    end

    def default_attributes_for(id)
      find(id).extract_attributes
    end

    def create(id)
      find(id).create
    end

    def definitions
      @definitions ||= {}
    end
  end
end
