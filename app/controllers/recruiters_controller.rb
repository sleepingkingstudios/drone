# app/controllers/recruiters_controller.rb

class RecruitersController < ApplicationController
  before_action :build_recruiter, :only => %i(new create)
  before_action :load_recruiter,  :only => %i(show edit update destroy)
  before_action :load_recruiters_collection, :only => %i(index)

  # GET /recruiters
  def index

  end # action index

  # GET /recruiters/new
  def new

  end # action new

  # POST /recruiters
  def create
    if @recruiter.save
      flash[:notice] = "Recruiter successfully created."

      redirect_to(recruiter_path @recruiter)
    else
      flash[:error] = "Unable to create recruiter."

      render(:new)
    end # if-else
  end # action create

  # GET /recruiters/:id
  def show

  end # action show

  # GET /recruiters/:id/edit
  def edit

  end # action edit

  # PATCH /recruiters/:id
  def update
    if @recruiter.update_attributes params_for_recruiter
      flash[:notice] = "Recruiter successfully updated."

      redirect_to(recruiter_path @recruiter)
    else
      flash[:error] = "Unable to update recruiter."

      render(:edit)
    end # if-else
  end # action update

  # DELETE /recruiters/:id
  def destroy
    @recruiter.destroy

    flash[:notice] = "Recruiter successfully destroyed."

    redirect_to recruiters_path
  end # action destroy

  private

  def build_recruiter
    @recruiter = Recruiter.new params_for_recruiter
  end # method build_role

  def load_recruiter
    @recruiter = Recruiter.find(params[:id])
  end # method load_recruiter

  def load_recruiters_collection
    @recruiters = Recruiter.all
  end # method load_recruiters_collection

  def params_for_recruiter
    params.fetch(:recruiter, {}).permit(:agency, :email, :name)
  end # method params_for_role

  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    flash[:error] = "Recruiter(s) not found with id(s) #{exception.params.join(', ')}."

    redirect_to(recruiters_path)
  end # rescue_from
end # controller RecruitersController
