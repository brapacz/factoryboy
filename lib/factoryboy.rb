require "factoryboy/version"
require "byebug"

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
  
  class Definition < Struct.new(:model, :config, :block)
    def class
      config[:class] || model
    end
  end
  
  class ValueExtractor
    attr_reader :attributes
    
    def initialize(block)
      @attributes = {}
      instance_eval(&block) if block
    end
    
    def method_missing(method, *args)
      set(method, *args)
    end
    
    private
    
    def set(method, value)
      attributes[method] = value
    end
  end
end
