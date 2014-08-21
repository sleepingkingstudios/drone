# spec/models/role_events/role_interview_event_spec.rb

require 'rails_helper'

RSpec.describe RoleInterviewEvent, :type => :model do
  let(:attributes) { attributes_for(:role_interview_event) }
  let(:instance)   { described_class.new attributes }

  ### Class Methods ###

  describe '::SUBTYPES' do
    it 'lists the valid types' do
      expect(described_class::SUBTYPES).to contain_exactly *%w(
        in_person
        phone
      ) # end array
    end # it

    it 'is immutable' do
      expect { described_class::SUBTYPES << 'malicious' }.to raise_error RuntimeError, /can't modify/
    end # it
  end # describe

  ### Attributes ###

  describe '#notes' do
    it { expect(instance).to have_property(:notes) }

    it { expect(instance.notes).to be == attributes[:notes] }
  end # describe

  describe '#subtype' do
    it { expect(instance).to have_property(:subtype) }

    it { expect(instance.subtype).to be == attributes[:subtype] }
  end # describe

  ### Validation ###

  describe 'validation' do
    it { expect(instance).to be_valid }

    describe 'subtype must be present' do
      let(:attributes) { super().merge :subtype => nil }

      it { expect(instance).to have_errors.on(:subtype).with_message("can't be blank") }
    end # it

    describe 'subtype must be in ::SUBTYPES' do
      let(:attributes) { super().merge :subtype => 'U-boat' }

      it { expect(instance).to have_errors.on(:subtype).with_message('is not included in the list') }
    end # describe
  end # describe
end # describe
