# app/models/role.rb

class Role
  include Mongoid::Document
  include Mongoid::Timestamps

  STATES = %w(open applied closed).freeze

  ### Class Methods ###

  class << self
    def closed_states
      %w(closed)
    end # method closed_states
  end # class << self

  ### Attributes ###

  field :applied_at, :type => DateTime
  field :company,    :type => String
  field :state,      :type => String
  field :title,      :type => String
  field :urls,       :type => Array

  ### Validations ###

  validates :company, :presence => true
  validates :state,   :presence => true, :inclusion => { :in => STATES }

  ### Instance Methods ###

  def closed?
    self.class.closed_states.include?(state)
  end # method closed?

  def open?
    !closed?
  end # method open?
end # model Role
