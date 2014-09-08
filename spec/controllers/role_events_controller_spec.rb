# spec/controllers/role_events_controller_spec.rb

require 'rails_helper'

RSpec.describe RoleEventsController, :type => :controller do
  shared_context 'with one role', :roles => :one do
    let(:role_attributes) { defined?(super) ? super() : {} }
    let!(:role)           { create(:role, role_attributes) }
    let(:role_id)         { role.id }
  end # shared_context

  shared_context 'with one event', :events => :one do
    let(:event_type)       { :role_event }
    let(:event_attributes) { (defined?(super) ? super() : {}).merge :role => role }
    let!(:event)           { create(event_type, event_attributes) }
    let(:event_id)         { event.id }
  end # shared_context

  shared_context 'with one interview', :interviews => :one do
    include_context 'with one event' do
      let(:event_type) { :role_interview_event }
    end # include_context
  end # shared_context

  shared_examples 'without a role redirects to roles_path' do
    context 'without a role' do
      let(:role_id) { generate(:id) }

      it 'redirects to roles_path' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(roles_path)

        expect(request.flash[:error]).not_to be_blank
      end # it
    end # context
  end # shared_examples

  shared_examples 'without an event redirects to role_path' do
    context 'without an event' do
      it 'redirects to role_path' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(role_path role)

        expect(request.flash[:error]).not_to be_blank
      end # it
    end # context
  end # shared_examples

  let(:params)  { { :role_id => role_id } }

  describe '#index', :roles => :many do
    def perform_action
      get :index, params
    end # method perform_action

    expect_behavior 'without a role redirects to roles_path'

    context 'with a created role', :roles => :one do
      it 'redirects to role_path' do
        perform_action

        expect(response.status).to be == 302
        expect(response).to redirect_to(role_path role)
      end # it
    end # context
  end # describe

  describe '#new' do
    def perform_action
      get :new, params
    end # method perform_action

    expect_behavior 'without a role redirects to roles_path'

    context 'with a created role', :roles => :one do
      it 'renders the new template' do
        perform_action

        expect(response.status).to be == 200
        expect(response).to render_template(:new)

        expect(assigns.fetch(:role)).to be == role
        expect(assigns.fetch(:event)).to be_a RoleEvent
      end # it

      context 'with a specified short type' do
        let(:params) { super().merge :event_type => 'interview' }

        it 'sets the event type' do
          perform_action

          expect(assigns.fetch(:event)).to be_a RoleInterviewEvent
        end # it
      end # it

      context 'with a specified full type' do
        let(:params) { super().merge :event_type => 'RoleInterviewEvent' }

        it 'sets the event type' do
          perform_action

          expect(assigns.fetch(:event)).to be_a RoleInterviewEvent
        end # it
      end # it
    end # context
  end # describe

  describe '#create' do
    let(:event_attributes) { {} }
    let(:params)           { super().merge :role_event => event_attributes }

    def perform_action
      post :create, params
    end # method perform_action

    expect_behavior 'without a role redirects to roles_path'

    context 'with a created role', :roles => :one do
      describe 'with invalid params for an interview' do
        let(:event_attributes) { super().merge :_type => 'RoleInterviewEvent', :subtype => nil }

        it 'renders the new template' do
          perform_action

          expect(response.status).to be == 200
          expect(response).to render_template(:new)

          expect(request.flash[:error]).not_to be_blank

          expect(assigns.fetch(:role)).to be == role
          expect(assigns.fetch(:event)).to be_a RoleInterviewEvent
          event_attributes.each do |attribute, value|
            expect(assigns.fetch(:event).send attribute).to be == value
          end # each
        end # it

        it 'does not create an event' do
          expect { perform_action }.not_to change { role.reload.events.count }
        end # it
      end # describe

      describe 'with valid params for an interview' do
        let(:event_attributes) { super().merge(attributes_for(:role_interview_event)).merge :_type => 'RoleInterviewEvent' }

        it 'redirects to role_path' do
          perform_action

          expect(response.status).to be == 302
          expect(response).to redirect_to(role_event_path(role, assigns.fetch(:event)))

          expect(request.flash[:notice]).not_to be_blank
        end # it

        it 'creates an event' do
          expect { perform_action }.to change { role.reload.events.count }.by(1)
        end # it
      end # describe
    end # context
  end # describe

  describe '#show' do
    let(:id)     { generate(:id) }
    let(:params) { super().merge :id => id }

    def perform_action
      get :show, params
    end # method perform_action

    expect_behavior 'without a role redirects to roles_path'

    context 'with a created role', :roles => :one do
      expect_behavior 'without an event redirects to role_path'

      context 'with a created event', :events => :one do
        let(:params) { super().merge :id => event.id }

        it 'renders the show template' do
          perform_action

          expect(response.status).to be == 200
          expect(response).to render_template(:show)

          expect(assigns.fetch(:role)).to be  == role
          expect(assigns.fetch(:event)).to be == event
        end # it
      end # context
    end # context
  end # describe

  describe '#edit' do
    let(:id)     { generate(:id) }
    let(:params) { super().merge :id => id }

    def perform_action
      get :edit, params
    end # method perform_action

    expect_behavior 'without a role redirects to roles_path'

    context 'with a created role', :roles => :one do
      expect_behavior 'without an event redirects to role_path'

      context 'with a created event', :events => :one do
        let(:params) { super().merge :id => event.id }

        it 'renders the edit template' do
          perform_action

          expect(response.status).to be == 200
          expect(response).to render_template(:edit)

          expect(assigns.fetch(:role)).to be  == role
          expect(assigns.fetch(:event)).to be == event
        end # it
      end # context
    end # context
  end # describe

  describe '#update' do
    let(:id)     { generate(:id) }
    let(:params) { super().merge :id => id }

    def perform_action
      patch :update, params
    end # method perform_action

    expect_behavior 'without a role redirects to roles_path'

    context 'with a created role', :roles => :one do
      expect_behavior 'without an event redirects to role_path'

      context 'with a created interview', :interviews => :one do
        let(:id)     { event.id }
        let(:params) { super().merge :role_event => event_params }

        describe 'with invalid params for an interview' do
          let(:event_params) { { :subtype => nil, :notes => "I've got a lovely bunch of coconuts..." } }

          it 'renders the edit template' do
            perform_action

            expect(response.status).to be == 200
            expect(response).to render_template(:edit)

            expect(request.flash[:error]).not_to be_blank

            expect(assigns.fetch(:role)).to be  == role
            expect(assigns.fetch(:event)).to be == event
            event_params.each do |attribute, value|
              expect(assigns.fetch(:event).send attribute).to be == value
            end # each
          end # it

          it 'does not update the event' do
            expect { perform_action }.not_to change { event.reload.notes }
          end # it
        end # describe

        describe 'with valid params for an interview' do
          let(:event_params) { { :subtype => 'in_person', :notes => "I've got a lovely bunch of coconuts..." } }

          it 'redirects to role_event_path' do
            perform_action

            expect(response.status).to be == 302
            expect(response).to redirect_to role_event_path(role, event)

            expect(request.flash[:notice]).not_to be_blank
          end # it

          it 'updates the event' do
            expect { perform_action }.to change { event.reload.notes }.to(event_params.fetch(:notes))
          end # it
        end # describe
      end # context
    end # context
  end # describe

  describe '#destroy' do
    let(:id)     { generate(:id) }
    let(:params) { super().merge :id => id }

    def perform_action
      delete :destroy, params
    end # method perform_action

    expect_behavior 'without a role redirects to roles_path'

    context 'with a created role', :roles => :one do
      expect_behavior 'without an event redirects to role_path'

      context 'without an event' do
        let(:role_id) { generate(:id) }

        it 'does not destroy an event' do
          expect { perform_action }.not_to change { role.reload.events.count }
        end # it
      end # context

      context 'with a created event', :events => :one do
        let(:params) { super().merge :id => event.id }

        it 'redirects to role_path' do
          perform_action

          expect(response.status).to be == 302
          expect(response).to redirect_to(role_path(role))

          expect(request.flash[:notice]).not_to be_blank
        end # it

        it 'destroys the event' do
          expect { perform_action }.to change { role.reload.events.count }.by(-1)
        end # it
      end # context
    end # context
  end # describe
end # describe
