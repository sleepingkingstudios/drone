# app/presenters/recruiter_presenter.rb

class RecruiterPresenter < Presenter
  alias_method :recruiter, :object

  delegate :name, :to => :recruiter

  class << self
    def select_options_for_recruiters
      [['(none)', nil]].concat(Recruiter.all.map { |recruiter|
        [new(recruiter).label, recruiter.id]
      }) # end map
    end # class method select_options_for_recruiters
  end # class << self

  def agency
    recruiter.agency.blank? ? empty_value : recruiter.agency
  end # method title

  def label
    recruiter.agency.blank? ? name : "#{name} at #{agency}"
  end # method label

  private

  def empty_value
    content_tag(:span, '(none)', :class => 'light')
  end # method empty_value
end # class
