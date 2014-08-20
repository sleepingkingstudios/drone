# app/presenters/role_presenter.rb

class RolePresenter < Presenter
  alias_method :role, :object

  delegate :company, :to => :role

  def applied_at
    role.applied_at.blank? ? empty_value : role.applied_at.strftime('%F')
  end # method applied_at

  def label
    role.title.blank? ? company : "#{title} at #{company}"
  end # method label

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
