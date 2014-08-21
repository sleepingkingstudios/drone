# app/models/role_event.rb

class RoleEvent
  include Mongoid::Document
  include Mongoid::Timestamps

  ### Attributes ###

  field :event_at, :type => DateTime
  field :notes,    :type => String

  ### Relations ###

  embedded_in :role, :inverse_of => :events
end # model RoleEvent
