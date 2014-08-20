# spec/models/role_spec.rb

require 'rails_helper'

RSpec.describe Role, :type => :model do
  let(:attributes) { attributes_for(:role) }
  let(:instance)   { described_class.new attributes }

  describe '::STATES' do
    it 'lists the valid states' do
      expect(described_class::STATES).to contain_exactly *%w(
        applied
        closed
        open
      ) # end array
    end # it

    it 'is immutable' do
      expect { described_class::STATES << 'malicious' }.to raise_error
    end # it
  end # describe

  ### Attributes ###

  describe '#applied_at' do
    it { expect(instance).to have_property(:applied_at) }

    it { expect(instance.applied_at).to be == attributes[:applied_at] }
  end # describe

  describe '#company' do
    it { expect(instance).to have_property(:company) }

    it { expect(instance.company).to be == attributes[:company] }
  end # describe

  describe '#state' do
    it { expect(instance).to have_property(:state) }

    it { expect(instance.state).to be == attributes[:state] }
  end # describe

  describe '#title' do
    it { expect(instance).to have_property(:title) }

    it { expect(instance.title).to be == attributes[:title] }
  end # describe

  describe '#urls' do
    it { expect(instance).to have_property(:urls) }

    it { expect(instance.urls).to be == attributes[:urls] }
  end # describe

  ### Validation ###

  describe 'validation' do
    it { expect(instance).to be_valid }

    describe 'company must be present' do
      let(:attributes) { super().merge :company => nil }

      it { expect(instance).to have_errors.on(:company).with_message("can't be blank") }
    end # describe

    describe 'state must be present' do
      let(:attributes) { super().merge :state => nil }

      it { expect(instance).to have_errors.on(:state).with_message("can't be blank") }
    end # describe

    describe 'state must be in ::STATES' do
      let(:attributes) { super().merge :state => 'confusion' }

      it { expect(instance).to have_errors.on(:state).with_message('is not included in the list') }
    end # describe
  end # describe

  ### Instance Methods ###

  describe '#open?' do
    it { expect(instance).to respond_to(:open?).with(0).arguments }

    context 'with state = "applied"' do
      let(:attributes) { super().merge :state => 'applied' }

      it { expect(instance).to be_open }
    end # context

    context 'with state = "closed"' do
      let(:attributes) { super().merge :state => 'closed' }

      it { expect(instance).not_to be_open }
    end # context

    context 'with state = "open"' do
      let(:attributes) { super().merge :state => 'open' }

      it { expect(instance).to be_open }
    end # context
  end # describe

  describe '#closed?' do
    it { expect(instance).to respond_to(:closed?).with(0).arguments }

    context 'with state = "applied"' do
      let(:attributes) { super().merge :state => 'applied' }

      it { expect(instance).not_to be_closed }
    end # context

    context 'with state = "closed"' do
      let(:attributes) { super().merge :state => 'closed' }

      it { expect(instance).to be_closed }
    end # context

    context 'with state = "open"' do
      let(:attributes) { super().merge :state => 'open' }

      it { expect(instance).not_to be_closed }
    end # context
  end # describe
end # describe
