# spec/helpers/application_helper_spec.rb

require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  let(:instance) { Object.new.extend described_class }

  describe '#present' do
    it { expect(instance).to respond_to(:present).with(1).argument }

    describe 'with an object' do
      let(:object) { Object.new }

      it { expect(instance.present object).to be_a Presenter }

      it 'decorates the object' do
        expect(instance.present(object).object).to be object
      end # it
    end # describe

    describe 'with a class object' do
      let(:object) { Role.new }

      it { expect(instance.present object).to be_a RolePresenter }

      it 'decorates the object' do
        expect(instance.present(object).object).to be object
      end # it
    end # describe

    describe 'with a subclassed object without a custom presenter' do
      let(:subclass) { Class.new(Role) }
      let(:object)   { subclass.new }

      before(:each)  { allow(subclass).to receive(:name).and_return("AnonymousSubclass") }

      it { expect(instance.present object).to be_a RolePresenter }

      it 'decorates the object' do
        expect(instance.present(object).object).to be object
      end # it
    end # describe
  end # describe
end # describe
