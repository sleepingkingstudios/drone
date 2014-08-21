# app/models/recruiter.rb

class Recruiter
  include Mongoid::Document
  include Mongoid::Timestamps

  ### Attributes ###

  field :agency, :type => String
  field :name,   :type => String

  ### Relations ###

  has_many :roles

  ### Validation ###

  validates :name, :presence => true
end # model Recruiter
