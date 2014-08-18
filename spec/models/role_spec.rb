# spec/models/role_spec.rb

require 'rails_helper'

RSpec.describe Role, :type => :model do
  let(:attributes) { attributes_for(:role) }
  let(:instance)   { described_class.new attributes }

  ### Attributes ###

  describe '#applied_at' do
    it { expect(instance).to have_property(:applied_at) }

    it { expect(instance.applied_at).to be == attributes[:applied_at] }
  end # describe

  describe '#company' do
    it { expect(instance).to have_property(:company) }

    it { expect(instance.company).to be == attributes[:company] }
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
  end # describe

  ### Instance Methods ###

  describe '#applied?' do
    it { expect(instance).to have_reader(:applied?).with(false) }

    context 'with an applied_at date' do
      let(:attributes) { super().merge :applied_at => 10.minutes.ago }

      it { expect(instance.applied? ).to be true }
    end # context
  end # describe
end # describe
