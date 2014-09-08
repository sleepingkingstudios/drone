# spec/presenters/role_interview_event_presenter_spec.rb

require 'rails_helper'

RSpec.describe RoleInterviewEventPresenter, :type => :decorator do
  let(:attributes)  { {} }
  let(:role_event)  { build(:role_interview_event, attributes) }
  let(:instance)    { described_class.new role_event }
  let(:empty_value) { '<span class="light">(none)</span>' }

  describe '#event' do
    it { expect(instance).to have_reader(:event).with(role_event) }
  end # describe

  describe '#select_options_for_subtype' do
    let(:options) do
      RoleInterviewEvent::SUBTYPES.map do |value|
        [value.split('_').map(&:capitalize).join(' '), value]
      end # map
    end # let

    it { expect(instance).to have_reader(:select_options_for_subtype).with(options) }
  end # describe

  describe '#type' do
    let(:attributes) { super().merge :subtype => nil }

    it { expect(instance).to have_reader(:type).with('Interview') }

    context 'with a subtype' do
      let(:attributes) { super().merge :subtype => 'phone' }

      it { expect(instance).to have_reader(:type).with('Phone Interview') }
    end # context
  end # describe
end # describe
