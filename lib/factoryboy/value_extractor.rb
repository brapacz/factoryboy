module Factoryboy
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
