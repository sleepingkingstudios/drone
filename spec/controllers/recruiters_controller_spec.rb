# spec/controllers/recruiters_controller_spec.rb

require 'rails_helper'

RSpec.describe RecruitersController, :type => :controller do
  shared_context 'with one recruiter', :recruiters => :one do
    let(:recruiter_attributes) { defined?(super) ? super() : {} }
    let!(:recruiter)           { create(:recruiter, recruiter_attributes) }
  end # shared_context

  shared_context 'with many recruiters', :recruiters => :many do
    let(:recruiter_attributes) { defined?(super) ? super() : {} }
    let!(:recruiters)          { Array.new(3).map { create(:recruiter, recruiter_attributes) } }
  end # shared_context

  let(:params) { {} }

  describe '#index', :recruiters => :many do
    def perform_action
      get :index
    end # method perform_action

    it 'renders the index template' do
      perform_action

      expect(response.status).to be == 200
      expect(response).to render_template(:index)

      expect(assigns.fetch(:recruiters)).to be == recruiters
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

      expect(assigns.fetch(:recruiter)).to be_a Recruiter
    end # it
  end # describe

  describe '#create' do
    let(:recruiter_attributes) { {} }
    let(:params)               { { :recruiter => recruiter_attributes } }

    def perform_action
      post :create, params
    end # method perform_action

    describe 'with invalid params' do
      let(:recruiter_attributes) { super().merge :name => nil }

      it 'renders the new template' do
        perform_action

        expect(response.status).to be == 200
        expect(response).to render_template(:new)

        expect(request.flash[:error]).not_to be_blank

        expect(assigns.fetch(:recruiter)).to be_a Recruiter
        recruiter_attributes.each do |attribute, value|
          expect(assigns.fetch(:recruiter).send attribute).to be == value
        end # each
      end # it

      it 'does not create a recruiter' do
        expect { perform_action }.not_to change(Recruiter, :count)
      end # it
    end # describe

    describe 'with valid params' do
      let(:recruiter_attributes) { attributes_for(:recruiter) }

      it 'redirects to recruiter_path' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(recruiter_path(Recruiter.last))

        expect(request.flash[:notice]).not_to be_blank
      end # it

      it 'creates a recruiter' do
        expect { perform_action }.to change(Recruiter, :count).by(1)
      end # it
    end # describe
  end # describe

  describe '#show' do
    def perform_action
      get :show, params
    end # method perform_action

    context 'without a recruiter' do
      let(:id)     { generate(:id) }
      let(:params) { super().merge :id => id }

      it 'redirects to recruiters' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(recruiters_path)

        expect(request.flash[:error]).not_to be_blank
      end # it
    end # context

    context 'with a created recruiter', :recruiters => :one do
      let(:params) { super().merge :id => recruiter.id }

      it 'renders the show template' do
        perform_action

        expect(response.status).to be == 200
        expect(response).to render_template(:show)

        expect(assigns.fetch(:recruiter)).to be == recruiter
      end # it
    end # context
  end # describe

  describe '#edit' do
    def perform_action
      get :edit, params
    end # method perform_action

    context 'without a recruiter' do
      let(:id)     { generate(:id) }
      let(:params) { super().merge :id => id }

      it 'redirects to recruiters' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(recruiters_path)

        expect(request.flash[:error]).not_to be_blank
      end # it
    end # context

    context 'with a created recruiter', :recruiters => :one do
      let(:params) { super().merge :id => recruiter.id }

      it 'renders the edit template' do
        perform_action

        expect(response.status).to be == 200
        expect(response).to render_template(:edit)

        expect(assigns.fetch(:recruiter)).to be == recruiter
      end # it
    end # context
  end # describe

  describe '#update' do
    def perform_action
      patch :update, params
    end # method perform_action

    context 'without a recruiter' do
      let(:id)     { generate(:id) }
      let(:params) { super().merge :id => id }

      it 'redirects to recruiters' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(recruiters_path)

        expect(request.flash[:error]).not_to be_blank
      end # it
    end # context

    context 'with a created recruiter', :recruiters => :one do
      let(:params) { super().merge :id => recruiter.id, :recruiter => recruiter_params }

      context 'with invalid params' do
        let(:recruiter_params) { { :name => nil, :agency => 'Blue Sun' } }

        it 'renders the edit template' do
          perform_action

          expect(response.status).to be == 200
          expect(response).to render_template(:edit)

          expect(request.flash[:error]).not_to be_blank

          expect(assigns.fetch(:recruiter)).to be == recruiter
          recruiter_params.each do |attribute, value|
            expect(assigns.fetch(:recruiter).send attribute).to be == value
          end # each
        end # it

        it 'does not update the recruiter' do
          expect { perform_action }.not_to change { recruiter.reload.agency }
        end # it
      end # context

      context 'with valid params' do
        let(:recruiter_params) { { :name => 'Darth Vader', :agency => 'Galactic Empire' } }

        it 'redirects to recruiter_path' do
          perform_action

          expect(response.status).to be == 302
          expect(response).to redirect_to recruiter_path(recruiter)

          expect(request.flash[:notice]).not_to be_blank
        end # it

        it 'updates the recruiter' do
          expect { perform_action }.to change { recruiter.reload.agency }.to(recruiter_params.fetch(:agency))
        end # it
      end # context
    end # context
  end # describe

  describe '#destroy' do
    def perform_action
      delete :destroy, params
    end # method perform_action

    context 'without a recruiter' do
      let(:id)     { generate(:id) }
      let(:params) { super().merge :id => id }

      it 'redirects to recruiters' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(recruiters_path)

        expect(request.flash[:error]).not_to be_blank
      end # it

      it 'does not destroy a recruiter' do
        expect { perform_action }.not_to change(Recruiter, :count)
      end # it
    end # context

    context 'with a created recruiter', :recruiters => :one do
      let(:params) { super().merge :id => recruiter.id }

      it 'redirects to recruiters' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(recruiters_path)

        expect(request.flash[:notice]).not_to be_blank
      end # it

      it 'destroys the recruiter' do
        expect { perform_action }.to change(Recruiter, :count).by(-1)
      end # it
    end # context
  end # describe
end # describe
