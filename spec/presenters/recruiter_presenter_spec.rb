# spec/presenters/recruiter_presenter_spec.rb

require 'rails_helper'

RSpec.describe RecruiterPresenter, :type => :decorator do
  shared_context 'with many recruiters', :recruiters => :many do
    let(:recruiter_attributes) { defined?(super) ? super() : {} }
    let!(:recruiters)          { Array.new(3).map { create(:recruiter, recruiter_attributes) } }
  end # shared_context

  let(:attributes)  { {} }
  let(:recruiter)   { build(:recruiter, attributes) }
  let(:instance)    { described_class.new recruiter }
  let(:empty_value) { '<span class="light">(none)</span>' }

  describe '::select_options_for_recruiters' do
    let(:options) { [['(none)', nil]] }

    it { expect(described_class).to have_reader(:select_options_for_recruiters).with(options) }

    context 'with many recruiters', :recruiters => :many do
      let(:agency)               { 'Dirty Deeds Done Dirt Cheap' }
      let(:recruiter_attributes) { { :agency => agency } }
      let(:options) do
        super().concat(Recruiter.all.map { |recruiter| [described_class.new(recruiter).label, recruiter.id] })
      end # let

      it { expect(described_class).to have_reader(:select_options_for_recruiters).with(options) }
    end # context
  end # describe

  describe '#agency' do
    let(:attributes) { super().merge :agency => 'Encom' }

    it { expect(instance).to have_reader(:agency).with(recruiter.agency) }

    context 'with an empty agency' do
      let(:attributes) { super().merge :agency => nil }

      it { expect(instance.agency).to be == empty_value }
    end # context
  end # describe

  describe '#label' do
    let(:attributes) { super().merge :agency => 'Evil Inc.' }
    let(:label)      { "#{recruiter.name} at #{recruiter.agency}" }

    it { expect(instance).to have_reader(:label).with(label) }

    context 'with an empty agency' do
      let(:attributes) { super().merge :agency => nil }
      let(:label)      { recruiter.name }

      it { expect(instance.label).to be == label }
    end # context
  end # describe

  describe '#name' do
    it { expect(instance).to have_reader(:name).with(recruiter.name) }
  end # describe

  describe '#recruiter' do
    it { expect(instance).to have_reader(:recruiter).with(recruiter) }
  end # describe
end # describe
