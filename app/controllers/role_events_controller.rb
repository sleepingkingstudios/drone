# app/controllers/role_events_controller.rb

class RoleEventsController < ApplicationController
  before_action :load_role
  before_action :build_event, :only => %i(new create)
  before_action :load_event,  :only => %i(show edit update destroy)

  # GET /roles/:role_id/events
  def index
    redirect_to(role_path @role)
  end # action index

  # GET /roles/:role_id/events/new
  def new

  end # action new

  # POST /roles/:role_id/events
  def create
    if @event.save
      flash[:notice] = "Event successfully created."

      redirect_to(role_event_path @role, @event)
    else
      flash[:error] = "Unable to create event."

      render(:new)
    end # if-else
  end # action create

  # GET /roles/:role_id/events/:id
  def show

  end # action show

  # GET /roles/:role_id/events/:id/edit
  def edit

  end # action edit

  # PATCH /roles/:role_id/events/:id
  def update
    if @event.update_attributes params_for_polymorphic_event
      flash[:notice] = "Event successfully updated."

      redirect_to(role_event_path @role, @event)
    else
      flash[:error] = "Unable to update event."

      render(:edit)
    end # if-else
  end # action update

  # DELETE /roles/:role_id/events/:id
  def destroy
    @event.destroy

    flash[:notice] = "Event successfully destroyed."

    redirect_to role_path(@role)
  end # action destroy

  private

  def build_event
    @event = event_class.new params_for_polymorphic_event
    @event.role = @role
  end # method build_role

  def event_class
    event_type.constantize
  rescue NameError => exception
    RoleEvent
  end # method event_class

  def event_type
    if !@event.try(:_type).blank?
      @event._type
    elsif params.fetch(:role_event, {}).key?(:_type)
      params.fetch(:role_event, {}).fetch(:_type)
    elsif params.fetch(:event_type, false)
      raw_type = params.fetch(:event_type)
      if raw_type =~ /\ARole\w+Event\z/
        raw_type
      else
        "Role#{raw_type.capitalize}Event"
      end # if-else
    end # if-elsif-else
  end # method event_type

  def load_event
    @event = @role.events.find(params[:id])
  rescue Mongoid::Errors::DocumentNotFound => exception
    flash[:error] = "Event(s) not found with id(s) #{exception.params.join(', ')}."

    redirect_to(role_path @role)
  end # method load_role

  def load_role
    @role = Role.find(params[:role_id])
  rescue Mongoid::Errors::DocumentNotFound => exception
    flash[:error] = "Role(s) not found with id(s) #{exception.params.join(', ')}."

    redirect_to(roles_path)
  end # method load_role

  def params_for_event
    params.fetch(:role_event, {}).permit(:notes)
  end # method params_for_event

  def params_for_polymorphic_event
    case event_type
    when 'RoleInterviewEvent'
      params_for_interview
    else
      params_for_event
    end # case
  end # method params_for_polymorphic_event

  def params_for_interview
    params_for_event.merge params.fetch(:role_event, {}).permit(:subtype)
  end # method params_for_interview
end # class
