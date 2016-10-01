require "factoryboy/version"
require "factoryboy/value_extractor"
require "factoryboy/definition"
require "factoryboy/registry"

module Factoryboy
  class << self
    extend Forwardable

    def_delegators :registry, :define_factory, :build

    private

    def registry
      @registry ||= Registry.new
    end
  end
end
