# app/models/role_events/role_interview_event.rb

class RoleInterviewEvent < RoleEvent
  SUBTYPES = %w(in_person phone).freeze

  ### Attributes ###

  field :notes,   :type => String
  field :subtype, :type => String

  ### Validations ###

  validates :subtype, :presence => true, :inclusion => { :in => SUBTYPES }
end # class RoleInterviewEvent
