module Factoryboy
  class Definition < Struct.new(:model, :config, :block)
    def class
      config[:class] || model
    end
  end
end
