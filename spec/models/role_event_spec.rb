# spec/models/role_event_spec.rb

require 'rails_helper'

RSpec.describe RoleEvent, :type => :model do
  shared_context 'with one role', :roles => :one do
    let(:role)       { build(:role) }
    let(:attributes) { super().merge :role => role }
  end # shared_context

  let(:attributes) { attributes_for(:role_event) }
  let(:instance)   { described_class.new attributes }

  ### Attributes ###

  describe '#event_at' do
    it { expect(instance).to have_property(:event_at) }

    it { expect(instance.event_at).to be == attributes[:event_at] }
  end # describe

  describe '#notes' do
    it { expect(instance).to have_property(:notes) }

    it { expect(instance.notes).to be == attributes[:notes] }
  end # describe

  ### Relations ###

  describe 'embedded_in :role' do
    it { expect(instance).to have_reader(:role).with(nil) }

    context 'with one role', :roles => :one do
      it { expect(instance.role).to be == role }
    end # context
  end # describe

  ### Validation ###

  describe 'validation' do
    it { expect(instance).to be_valid }
  end # describe
end # describe
