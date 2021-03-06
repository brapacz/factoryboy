require 'spec_helper'

describe Factoryboy::Registry do
  let(:model) do
    Class.new do
      attr_accessor :name
      def self.inspect# just for test name generation
        "#<AutogeneratedModelClass>"
      end
    end
  end
  let(:name) { 'Adam' }

  describe '.build' do
    context 'when factory is undefined' do
      it { expect { subject.build(:missing) }.to raise_error(Factoryboy::Error, 'Factory :missing is not defined') }
    end

    context 'when factory has no attributes defined' do
      before { subject.define_factory(model) }

      it { expect(subject.build(model)).to be_a(model).and have_attributes(name: nil) }
      it { expect(subject.build(model, name: name)).to be_a(model).and have_attributes(name: name) }
    end

    context 'when factory has defined attributes' do
      before { subject.define_factory(model) { name 'Ewa' } }

      it { expect(subject.build(model)).to be_a(model).and have_attributes(name: 'Ewa') }
      it { expect(subject.build(model, name: name)).to be_a(model).and have_attributes(name: name) }
    end

    context 'when factory has defined attributes and specified class' do
      before { subject.define_factory(:admin, class: model) { name 'Ewa' } }

      it { expect(subject.build(:admin)).to be_a(model).and have_attributes(name: 'Ewa') }
      it { expect(subject.build(:admin, name: name)).to be_a(model).and have_attributes(name: name) }
    end
  end
end
