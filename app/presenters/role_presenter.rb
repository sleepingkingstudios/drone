# app/presenters/role_presenter.rb

class RolePresenter < Presenter
  alias_method :role, :object

  delegate :company, :to => :role

  def agency
    role.recruiter.try(:agency).blank? ? empty_value : role.recruiter.agency
  end # method agency

  def applied_at
    role.applied_at.blank? ? empty_value : role.applied_at.strftime('%F')
  end # method applied_at

  def label
    role.title.blank? ? company : "#{title} at #{company}"
  end # method label

  def recruiter
    role.recruiter.blank? ? empty_value : role.recruiter.name
  end # method recruiter

  def recruiter_link
    if role.recruiter.blank?
      empty_value
    else
      content = "#{content_tag(:span, nil, :class => 'glyphicon glyphicon-user')} #{role.recruiter.name}".html_safe
      link_to content, recruiter_path(role.recruiter.id)
    end # if-else
  end # method recruiter_link

  def select_options_for_state
    Role::STATES.map { |value| [value.capitalize, value] }
  end # method

  def state
    role.state.blank? ? 'Invalid' : role.state.capitalize
  end # method state

  def title
    role.title.blank? ? empty_value : role.title
  end # method title

  private

  def empty_value
    content_tag(:span, '(none)', :class => 'light')
  end # method empty_value
end # class
