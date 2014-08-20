# app/controllers/roles_controller.rb

require 'form_builders/bootstrap_horizontal_form_builder'

class RolesController < ApplicationController
  before_action :build_role, :only => %i(new create)
  before_action :load_role,  :only => %i(show edit update destroy)
  before_action :load_roles_collection, :only => %i(index)

  # GET /roles
  def index

  end # action index

  # GET /roles/new
  def new
    @role.state ||= 'open'
  end # action new

  # POST /roles
  def create
    @role.state ||= 'open'

    if @role.save
      flash[:notice] = "Role successfully created."

      redirect_to(role_path @role)
    else
      flash[:error] = "Unable to create role."

      render(:new)
    end # if-else
  end # action create

  # GET /roles/:id
  def show

  end # action show

  # GET /roles/:id/edit
  def edit

  end # action edit

  # PATCH /roles/:id
  def update
    if @role.update_attributes params_for_role
      flash[:notice] = "Role successfully updated."

      redirect_to(role_path @role)
    else
      flash[:error] = "Unable to update role."

      render(:edit)
    end # if-else
  end # action update

  # DELETE /roles/:id
  def destroy
    @role.destroy

    flash[:notice] = "Role successfully destroyed."

    redirect_to roles_path
  end # action destroy

  private

  def build_role
    @role = Role.new params_for_role
  end # method build_role

  def load_role
    @role = Role.find(params[:id])
  end # method load_role

  def load_roles_collection
    @roles = Role.all
  end # method load_roles_collection

  def params_for_role
    params.fetch(:role, {}).permit(:company, :state, :title)
  end # method params_for_role

  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    flash[:error] = "Role(s) not found with id(s) #{exception.params.join(', ')}."

    redirect_to(roles_path)
  end # rescue_from
end # controller
