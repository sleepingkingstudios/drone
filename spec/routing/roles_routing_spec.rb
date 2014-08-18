# spec/routing/roles_routing_spec.rb

require 'rails_helper'

RSpec.describe 'routing for roles', :type => :routing do
  let(:controller) { 'roles' }

  describe 'GET /roles' do
    let(:path)   { 'roles' }
    let(:action) { 'index' }

    it 'routes to RolesController#index' do
      expect(:get => "/#{path}").to route_to({
        :controller  => controller,
        :action      => action
      }) # end expect
    end # it
  end # describe
end # describe
