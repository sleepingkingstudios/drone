# spec/controllers/roles_controller_spec.rb

require 'rails_helper'

RSpec.describe RolesController, :type => :controller do
  describe '#index' do
    def perform_action
      get :index
    end # method perform_action

    it 'renders the index template' do
      perform_action
      expect(response.status).to be == 200
      expect(response).to render_template(:index)
    end # it
  end # describe
end # describe
