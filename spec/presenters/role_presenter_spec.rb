# spec/presenters/role_presenter_spec.rb

require 'rails_helper'

RSpec.describe RolePresenter, :type => :decorator do
  let(:attributes) { {} }
  let(:role)       { build(:role, attributes) }
  let(:instance)   { described_class.new role }

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

  describe '#role' do
    it { expect(instance).to have_reader(:role).with(role) }
  end # describe

  describe '#title' do
    let(:attributes) { super().merge :title => 'Minion' }

    it { expect(instance).to have_reader(:title).with(role.title) }

    context 'with an empty title' do
      let(:attributes) { super().merge :title => nil }

      it { expect(instance.title).to be == '<span class="light">(none)</span>' }
    end # context
  end # describe
end # describe
