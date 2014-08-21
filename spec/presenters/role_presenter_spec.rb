# spec/presenters/role_presenter_spec.rb

require 'rails_helper'

RSpec.describe RolePresenter, :type => :decorator do
  shared_context 'with one recruiter', :recruiters => :one do
    let(:recruiter_attributes) { defined?(super) ? super() : {} }
    let(:recruiter)            { build(:recruiter, recruiter_attributes) }
    let(:attributes)           { super().merge :recruiter => recruiter }
  end # shared_context

  let(:attributes)  { {} }
  let(:role)        { build(:role, attributes) }
  let(:instance)    { described_class.new role }
  let(:empty_value) { '<span class="light">(none)</span>' }

  describe '#agency' do
    it { expect(instance).to have_reader(:agency).with(empty_value) }

    context 'with a recruiter', :recruiters => :one do
      let(:recruiter_attributes) { { :agency => nil } }

      it { expect(instance).to have_reader(:agency).with(empty_value) }

      context 'with an agency' do
        let(:agency)               { "Dirk Gently's Holistic Detective Agency" }
        let(:recruiter_attributes) { { :agency => agency } }

        it { expect(instance).to have_reader(:agency).with(agency) }
      end # context
    end # context
  end # describe

  describe '#applied_at' do
    let(:applied_at) { 1.days.ago }
    let(:attributes) { super().merge :applied_at => applied_at }

    it { expect(instance).to have_reader(:applied_at).with(applied_at.strftime('%F')) }

    context 'with an undefined date' do
      let(:attributes) { super().merge :applied_at => nil }

      it { expect(instance.applied_at).to be == empty_value }
    end # context
  end # describe

  describe '#company' do
    it { expect(instance).to have_reader(:company).with(role.company) }
  end # describe

  describe '#label' do
    let(:attributes) { super().merge :company => 'Evil Inc.', :title => 'Minion' }
    let(:label)      { "#{role.title} at #{role.company}" }

    it { expect(instance).to have_reader(:label).with(label) }

    context 'with an empty title' do
      let(:attributes) { super().merge :title => nil }
      let(:label)      { role.company }

      it { expect(instance.label).to be == label }
    end # context
  end # describe

  describe '#recruiter' do
    it { expect(instance).to have_reader(:recruiter).with(empty_value) }

    context 'with a recruiter', :recruiters => :one do
      it { expect(instance).to have_reader(:recruiter).with(recruiter.name) }
    end # context
  end # describe

  describe '#role' do
    it { expect(instance).to have_reader(:role).with(role) }
  end # describe

  describe '#select_options_for_state' do
    let(:options) do
      Role::STATES.map { |value| [value.capitalize, value] }
    end # let

    it { expect(instance).to have_reader(:select_options_for_state).with(options) }
  end # describe

  describe '#state' do
    it { expect(instance).to have_reader(:state).with(role.state.capitalize) }

    context 'with an undefined state' do
      let(:attributes) { { :state => nil } }

      it { expect(instance.state).to be == 'Invalid' }
    end # context
  end # describe

  describe '#title' do
    let(:attributes) { super().merge :title => 'Minion' }

    it { expect(instance).to have_reader(:title).with(role.title) }

    context 'with an empty title' do
      let(:attributes) { super().merge :title => nil }

      it { expect(instance.title).to be == empty_value }
    end # context
  end # describe
end # describe
