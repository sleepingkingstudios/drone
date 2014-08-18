# app/controllers/roles_controller.rb

class RolesController < ApplicationController
  before_action :build_role, :only => %i(new create)
  before_action :load_role,  :only => %i(show)

  # GET /roles
  def index

  end # action index

  # GET /roles/new
  def new

  end # action new

  # POST /roles
  def create
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

  private

  def build_role
    @role = Role.new params_for_role
  end # method build_role

  def load_role
    @role = Role.find(params[:id])
  end # method load_role

  def params_for_role
    params.fetch(:role, {}).permit(:company, :title)
  end # method params_for_role

  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    flash[:error] = "Role(s) not found with id(s) #{exception.params.join(', ')}."

    redirect_to(roles_path)
  end # rescue_from
end # controller
