require "factoryboy/version"
require "byebug"

module Factoryboy
  class << self
    def define_factory(model, &block)
      definitions[model] = block if block
    end
    
    def build(model, attributes = {})
      model.new.tap do |instance|
        ValueSetter.new(instance).apply(definitions[model]) if definitions.has_key? model
        attributes.each { |key, value| instance.public_send("#{key}=", value) }
      end
    end
    
    private
    
    def definitions
      @definitions ||= {}
    end
  end
  
  class ValueSetter
    def initialize(object)
      @object = object
    end
    
    def method_missing(method, *args)
      set(method, *args)
    end
    
    def apply(block)
      instance_eval(&block)
    end
    
    private
    
    def set(method, value)
      @object.public_send("#{method}=", value)
    end
  end
end
