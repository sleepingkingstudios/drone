# app/models/role.rb

class Role
  include Mongoid::Document
  include Mongoid::Timestamps

  field :applied_at, :type => DateTime
  field :company,    :type => String
  field :title,      :type => String
  field :urls,       :type => Array

  validates :company, :presence => true

  ### Instance Methods ###

  def applied?
    !applied_at.blank?
  end # method applied?
end # model Role
