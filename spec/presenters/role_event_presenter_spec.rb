# spec/presenters/role_event_presenter_spec.rb

require 'rails_helper'

RSpec.describe RoleEventPresenter, :type => :decorator do
  let(:attributes)  { {} }
  let(:role_event)  { build(:role_event, attributes) }
  let(:instance)    { described_class.new role_event }
  let(:empty_value) { '<span class="light">(none)</span>' }

  describe '#event' do
    it { expect(instance).to have_reader(:event).with(role_event) }
  end # describe

  describe '#event_at' do
    it { expect(instance).to have_reader(:event_at).with(empty_value) }

    context 'with an event date and time' do
      let(:datetime)   { 1.hour.ago }
      let(:expected)   { datetime.to_time.strftime('%a, %d %B %Y at %l:%M%P') }
      let(:attributes) { super().merge :event_at => datetime }

      it { expect(instance.event_at).to be == expected }
    end # context
  end # describe

  describe '#notes' do
    it { expect(instance).to have_reader(:notes).with(empty_value) }

    context 'with notes' do
      let(:notes)      { "IT is a truth universally acknowledged, that a single man in possession of a good fortune must be in want of a wife." }
      let(:attributes) { super().merge :notes => notes }

      it { expect(instance.notes).to be == notes }
    end # context
  end # describe

  describe '#type' do
    it { expect(instance).to have_reader(:type).with('Event') }

    context 'with a subclass' do
      let(:role_event) { build(:role_interview_event, attributes) }

      it { expect(instance.type).to be == 'Interview' }
    end # context
  end # describe

  describe '#summary' do
    it { expect(instance).to have_reader(:summary).with(empty_value) }
  end # describe
end # describe
