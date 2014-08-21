# spec/routing/role_events_routing_spec.rb 

RSpec.describe 'routing for roles', :type => :routing do
  let(:role_id)    { generate(:id) }
  let(:controller) { 'role_events' }

  describe 'GET /roles/:role_id/events' do
    let(:path)   { "/roles/#{role_id}/events" }
    let(:action) { 'index' }

    it 'routes to RoleEventsController#index' do
      expect(:get => path).to route_to({
        :controller => controller,
        :action     => action,
        :role_id    => role_id
      }) # end expect
    end # it

    describe 'role_events_path' do
      it { expect(role_events_path(role_id)).to be == path }
    end # describe
  end # describe

  describe 'GET /roles/:role_id/events/new' do
    let(:path)   { "/roles/#{role_id}/events/new" }
    let(:action) { 'new' }

    it 'routes to RoleEventsController#new' do
      expect(:get => path).to route_to({
        :controller => controller,
        :action     => action,
        :role_id    => role_id
      }) # end expect
    end # it

    describe 'new_role_event_path' do
      it { expect(new_role_event_path(role_id)).to be == path }
    end # describe
  end # describe

  describe 'GET /roles/:role_id/events/:id' do
    let(:id)     { generate(:id) }
    let(:path)   { "/roles/#{role_id}/events/#{id}" }
    let(:action) { 'show' }

    it 'routes to RoleEventsController#show' do
      expect(:get => path).to route_to({
        :controller => controller,
        :action     => action,
        :role_id    => role_id,
        :id         => id
      }) # end expect
    end # it

    describe 'role_event_path' do
      it { expect(role_event_path(role_id, id)).to be == path }
    end # it
  end # describe

  describe 'GET /roles/:role_id/events/:id/edit' do
    let(:id)     { generate(:id) }
    let(:path)   { "/roles/#{role_id}/events/#{id}/edit" }
    let(:action) { 'edit' }

    it 'routes to RoleEventsController#edit' do
      expect(:get => path).to route_to({
        :controller => controller,
        :action     => action,
        :role_id    => role_id,
        :id         => id
      }) # end expect
    end # it

    describe 'edit_role_event_path' do
      it { expect(edit_role_event_path(role_id, id)).to be == path }
    end # it
  end # describe

  describe 'POST /roles/:role_id/events' do
    let(:path)   { "/roles/#{role_id}/events" }
    let(:action) { 'create' }

    it 'routes to RoleEventsController#create' do
      expect(:post => path).to route_to({
        :controller => controller,
        :action     => action,
        :role_id    => role_id
      }) # end expect
    end # it
  end # describe

  describe 'PATCH /roles/:role_id/events/:id' do
    let(:id)     { generate(:id) }
    let(:path)   { "/roles/#{role_id}/events/#{id}" }
    let(:action) { 'update' }

    it 'routes to RoleEventsController#create' do
      expect(:patch => path).to route_to({
        :controller => controller,
        :action     => action,
        :role_id    => role_id,
        :id         => id
      }) # end expect
    end # it
  end # describe

  describe 'DELETE /roles/:role_id/events/:id' do
    let(:id)     { generate(:id) }
    let(:path)   { "/roles/#{role_id}/events/#{id}" }
    let(:action) { 'destroy' }

    it 'routes to RoleEventsController#destroy' do
      expect(:delete => path).to route_to({
        :controller => controller,
        :action     => action,
        :role_id    => role_id,
        :id         => id
      }) # end expect
    end # it
  end # describe
end # describe
