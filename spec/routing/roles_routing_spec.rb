# spec/routing/roles_routing_spec.rb

require 'rails_helper'

RSpec.describe 'routing for roles', :type => :routing do
  let(:controller) { 'roles' }

  describe 'GET /roles' do
    let(:path)   { '/roles' }
    let(:action) { 'index' }

    it 'routes to RolesController#index' do
      expect(:get => path).to route_to({
        :controller => controller,
        :action     => action
      }) # end expect
    end # it

    describe 'roles_path' do
      it { expect(roles_path).to be == path }
    end # describe
  end # describe

  describe 'GET /roles/new' do
    let(:path)   { '/roles/new' }
    let(:action) { 'new' }

    it 'routes to RolesController#new' do
      expect(:get => path).to route_to({
        :controller => controller,
        :action     => action
      }) # end expect
    end # it

    describe 'new_role_path' do
      it { expect(new_role_path).to be == path }
    end # describe
  end # describe

  describe 'GET /roles/:id' do
    let(:id)     { generate(:id) }
    let(:path)   { "/roles/#{id}" }
    let(:action) { 'show' }

    it 'routes to RolesController#show' do
      expect(:get => path).to route_to({
        :controller => controller,
        :action     => action,
        :id         => id
      }) # end expect
    end # it

    describe 'role_path' do
      it { expect(role_path(id)).to be == path }
    end # it
  end # describe

  describe 'GET /roles/:id/edit' do
    let(:id)     { generate(:id) }
    let(:path)   { "/roles/#{id}/edit" }
    let(:action) { 'edit' }

    it 'routes to RolesController#edit' do
      expect(:get => path).to route_to({
        :controller => controller,
        :action     => action,
        :id         => id
      }) # end expect
    end # it

    describe 'edit_role_path' do
      it { expect(edit_role_path(id)).to be == path }
    end # it
  end # describe

  describe 'POST /roles' do
    let(:path)   { '/roles' }
    let(:action) { 'create' }

    it 'routes to RolesController#create' do
      expect(:post => path).to route_to({
        :controller => controller,
        :action     => action
      }) # end expect
    end # it
  end # describe

  describe 'PATCH /roles/:id' do
    let(:id)     { generate(:id) }
    let(:path)   { "/roles/#{id}" }
    let(:action) { 'update' }

    it 'routes to RolesController#create' do
      expect(:patch => path).to route_to({
        :controller => controller,
        :action     => action,
        :id         => id
      }) # end expect
    end # it
  end # describe

  describe 'DELETE /roles/:id' do
    let(:id)     { generate(:id) }
    let(:path)   { "/roles/#{id}" }
    let(:action) { 'destroy' }

    it 'routes to RolesController#destroy' do
      expect(:delete => path).to route_to({
        :controller => controller,
        :action     => action,
        :id         => id
      }) # end expect
    end # it
  end # describe
end # describe
