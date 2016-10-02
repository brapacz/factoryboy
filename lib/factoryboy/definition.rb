module Factoryboy
  class Definition < Struct.new(:model, :config, :block)
    def extract_attributes
      ValueExtractor.new(block).attributes || {}
    end

    def create
      model_class.new
    end

    private

    def model_class
      config[:class] || model
    end
  end
end
