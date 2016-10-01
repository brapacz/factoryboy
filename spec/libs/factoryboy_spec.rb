require 'spec_helper'

describe Factoryboy do
  let(:registry_class) { Factoryboy::Registry }
  let(:object) { double(:object) }
  let(:params) { double(:params) }

  it 'has a version number' do
    expect(Factoryboy::VERSION).not_to be nil
  end

  it 'delegates .build to Factoryboy::Registry.build' do
    expect_any_instance_of(registry_class).to receive(:build).with(params).and_return(object)
    expect(described_class.build(params)).to eq object
  end

  it 'delegates .define_factory to Factoryboy::Registry.define_factory' do
    expect_any_instance_of(registry_class).to receive(:define_factory).with(params).and_return(object)
    expect(described_class.define_factory(params)).to eq object
  end
end
