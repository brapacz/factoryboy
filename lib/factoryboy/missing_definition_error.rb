module Factoryboy
  class MissingDefinitionError < Error
    def initialize(id)
      @id = id
    end

    def message
      "Factory #{@id.inspect} is not defined"
    end
  end
end
