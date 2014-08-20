# spec/controllers/roles_controller_spec.rb

require 'rails_helper'

RSpec.describe RolesController, :type => :controller do
  shared_context 'with one role', :roles => :one do
    let(:role_attributes) { defined?(super) ? super() : {} }
    let!(:role)           { create(:role, role_attributes) }
  end # shared_context

  shared_context 'with many roles', :roles => :many do
    let(:role_attributes) { defined?(super) ? super() : {} }
    let!(:roles)     { Array.new(3).map { create(:role, role_attributes) } }
  end # shared_context

  let(:params) { {} }

  describe '#index', :roles => :many do
    def perform_action
      get :index
    end # method perform_action

    it 'renders the index template' do
      perform_action

      expect(response.status).to be == 200
      expect(response).to render_template(:index)

      expect(assigns.fetch(:roles)).to be == roles
    end # it
  end # describe

  describe '#new' do
    def perform_action
      get :new
    end # method perform_action

    it 'renders the new template' do
      perform_action

      expect(response.status).to be == 200
      expect(response).to render_template(:new)

      expect(assigns.fetch(:role)).to be_a Role
    end # it
  end # describe

  describe '#create' do
    let(:role_attributes) { {} }
    let(:params)          { { :role => role_attributes } }

    def perform_action
      post :create, params
    end # method perform_action

    describe 'with invalid params' do
      let(:role_attributes) { super().merge :company => nil }

      it 'renders the new template' do
        perform_action

        expect(response.status).to be == 200
        expect(response).to render_template(:new)

        expect(request.flash[:error]).not_to be_blank

        expect(assigns.fetch(:role)).to be_a Role
        role_attributes.each do |attribute, value|
          expect(assigns.fetch(:role).send attribute).to be == value
        end # each
      end # it

      it 'does not create a role' do
        expect { perform_action }.not_to change(Role, :count)
      end # it
    end # describe

    describe 'with valid params' do
      let(:role_attributes) { attributes_for(:role) }

      it 'redirects to role_path' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(role_path(Role.last))

        expect(request.flash[:notice]).not_to be_blank
      end # it

      it 'creates a role' do
        expect { perform_action }.to change(Role, :count).by(1)
      end # it
    end # describe
  end # describe

  describe '#show' do
    def perform_action
      get :show, params
    end # method perform_action

    context 'without a role' do
      let(:id)     { generate(:id) }
      let(:params) { super().merge :id => id }

      it 'redirects to roles' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(roles_path)

        expect(request.flash[:error]).not_to be_blank
      end # it
    end # context

    context 'with a created role', :roles => :one do
      let(:params) { super().merge :id => role.id }

      it 'renders the show template' do
        perform_action

        expect(response.status).to be == 200
        expect(response).to render_template(:show)

        expect(assigns.fetch(:role)).to be == role
      end # it
    end # context
  end # describe

  describe '#edit' do
    def perform_action
      get :edit, params
    end # method perform_action

    context 'without a role' do
      let(:id)     { generate(:id) }
      let(:params) { super().merge :id => id }

      it 'redirects to roles' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(roles_path)

        expect(request.flash[:error]).not_to be_blank
      end # it
    end # context

    context 'with a created role', :roles => :one do
      let(:params) { super().merge :id => role.id }

      it 'renders the edit template' do
        perform_action

        expect(response.status).to be == 200
        expect(response).to render_template(:edit)

        expect(assigns.fetch(:role)).to be == role
      end # it
    end # context
  end # describe

  describe '#update' do
    def perform_action
      patch :update, params
    end # method perform_action

    context 'without a role' do
      let(:id)     { generate(:id) }
      let(:params) { super().merge :id => id }

      it 'redirects to roles' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(roles_path)

        expect(request.flash[:error]).not_to be_blank
      end # it
    end # context

    context 'with a created role', :roles => :one do
      let(:params) { super().merge :id => role.id, :role => role_params }

      context 'with invalid params' do
        let(:role_params) { { :company => nil, :title => 'Mo Zing' } }

        it 'renders the edit template' do
          perform_action

          expect(response.status).to be == 200
          expect(response).to render_template(:edit)

          expect(request.flash[:error]).not_to be_blank

          expect(assigns.fetch(:role)).to be_a Role
          role_params.each do |attribute, value|
            expect(assigns.fetch(:role).send attribute).to be == value
          end # each
        end # it

        it 'does not update the role' do
          expect { perform_action }.not_to change { role.reload.title }
        end # it
      end # context

      context 'with valid params' do
        let(:role_params) { { :company => 'Generic Fantasy Kingdom', :title => 'Evil Chancellor' } }

        it 'redirects to role_path' do
          perform_action

          expect(response.status).to be == 302
          expect(response).to redirect_to role_path(role)

          expect(request.flash[:notice]).not_to be_blank
        end # it

        it 'does updates the role' do
          expect { perform_action }.to change { role.reload.title }.to(role_params.fetch(:title))
        end # it
      end # context
    end # context
  end # describe

  describe '#destroy' do
    def perform_action
      delete :destroy, params
    end # method perform_action

    context 'without a role' do
      let(:id)     { generate(:id) }
      let(:params) { super().merge :id => id }

      it 'redirects to roles' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(roles_path)

        expect(request.flash[:error]).not_to be_blank
      end # it

      it 'does not destroy a role' do
        expect { perform_action }.not_to change(Role, :count)
      end # it
    end # context

    context 'with a created role', :roles => :one do
      let(:params) { super().merge :id => role.id }

      it 'redirects to roles' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(roles_path)

        expect(request.flash[:notice]).not_to be_blank
      end # it

      it 'destroys the role' do
        expect { perform_action }.to change(Role, :count).by(-1)
      end # it
    end # context
  end # describe
end # describe
