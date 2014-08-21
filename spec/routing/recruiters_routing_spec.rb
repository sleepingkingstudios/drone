# spec/routing/recruiters_routing_spec.rb

require 'rails_helper'

RSpec.describe 'routing for recruiters', :type => :routing do
  let(:controller) { 'recruiters' }

  describe 'GET /recruiters' do
    let(:path)   { '/recruiters' }
    let(:action) { 'index' }

    it 'routes to RecruitersController#index' do
      expect(:get => path).to route_to({
        :controller => controller,
        :action     => action
      }) # end expect
    end # it

    describe 'recruiters_path' do
      it { expect(recruiters_path).to be == path }
    end # describe
  end # describe

  describe 'GET /recruiters/new' do
    let(:path)   { '/recruiters/new' }
    let(:action) { 'new' }

    it 'routes to RecruitersController#new' do
      expect(:get => path).to route_to({
        :controller => controller,
        :action     => action
      }) # end expect
    end # it

    describe 'new_recruiter_path' do
      it { expect(new_recruiter_path).to be == path }
    end # describe
  end # describe

  describe 'GET /recruiters/:id' do
    let(:id)     { generate(:id) }
    let(:path)   { "/recruiters/#{id}" }
    let(:action) { 'show' }

    it 'routes to RecruitersController#show' do
      expect(:get => path).to route_to({
        :controller => controller,
        :action     => action,
        :id         => id
      }) # end expect
    end # it

    describe 'recruiter_path' do
      it { expect(recruiter_path(id)).to be == path }
    end # it
  end # describe

  describe 'GET /recruiters/:id/edit' do
    let(:id)     { generate(:id) }
    let(:path)   { "/recruiters/#{id}/edit" }
    let(:action) { 'edit' }

    it 'routes to RecruitersController#edit' do
      expect(:get => path).to route_to({
        :controller => controller,
        :action     => action,
        :id         => id
      }) # end expect
    end # it

    describe 'edit_recruiter_path' do
      it { expect(edit_recruiter_path(id)).to be == path }
    end # it
  end # describe

  describe 'POST /recruiters' do
    let(:path)   { '/recruiters' }
    let(:action) { 'create' }

    it 'routes to RecruitersController#create' do
      expect(:post => path).to route_to({
        :controller => controller,
        :action     => action
      }) # end expect
    end # it
  end # describe

  describe 'PATCH /recruiters/:id' do
    let(:id)     { generate(:id) }
    let(:path)   { "/recruiters/#{id}" }
    let(:action) { 'update' }

    it 'routes to RecruitersController#create' do
      expect(:patch => path).to route_to({
        :controller => controller,
        :action     => action,
        :id         => id
      }) # end expect
    end # it
  end # describe

  describe 'DELETE /recruiters/:id' do
    let(:id)     { generate(:id) }
    let(:path)   { "/recruiters/#{id}" }
    let(:action) { 'destroy' }

    it 'routes to RecruitersController#destroy' do
      expect(:delete => path).to route_to({
        :controller => controller,
        :action     => action,
        :id         => id
      }) # end expect
    end # it
  end # describe
end # describe
