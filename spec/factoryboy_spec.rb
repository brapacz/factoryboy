require 'spec_helper'

describe Factoryboy do
  it 'has a version number' do
    expect(Factoryboy::VERSION).not_to be nil
  end
  
  let(:model) do 
    Class.new do
      attr_accessor :name
    end
  end
  let(:name) { 'Adam' }
  
  describe '#build' do
    before { described_class.define_factory(model) }
    it { expect(described_class.build(model)).to be_a model }
    it { expect(described_class.build(model, name: name)).to be_a(model).and have_attributes(name: name) }
  end 
end
