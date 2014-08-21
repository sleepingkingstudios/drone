# spec/models/recruiter_spec.rb

require 'rails_helper'

RSpec.describe Recruiter, :type => :model do
  shared_context 'with many roles', :roles => :many do
    let(:roles)      { Array.new(3).map { build(:role) } }
    let(:attributes) { super().merge :roles => roles }
  end # shared_context

  let(:attributes) { attributes_for(:recruiter) }
  let(:instance)   { described_class.new attributes }

  ### Attributes ###

  describe '#agency' do
    it { expect(instance).to have_property(:agency) }

    it { expect(instance.agency).to be == attributes[:agency] }
  end # describe

  describe '#email' do
    it { expect(instance).to have_property(:email) }

    it { expect(instance.email).to be == attributes[:email] }
  end # describe

  describe '#name' do
    it { expect(instance).to have_property(:name) }

    it { expect(instance.name).to be == attributes[:name] }
  end # describe

  ### Relations ###

  describe 'has_many :roles' do
    it { expect(instance).to have_reader(:roles).with([]) }

    context 'with many roles', :roles => :many do
      it { expect(instance.roles).to be == roles }
    end # context
  end # describe

  ### Validation ###

  describe 'validation' do
    it { expect(instance).to be_valid }

    describe 'name must be present' do
      let(:attributes) { super().merge :name => nil }

      it { expect(instance).to have_errors.on(:name).with_message("can't be blank") }
    end # describe
  end # describe
end # describe
