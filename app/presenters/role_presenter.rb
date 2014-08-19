# app/presenters/role_presenter.rb

class RolePresenter < Presenter
  alias_method :role, :object

  delegate :company, :to => :role

  def label
    role.title.blank? ? company : "#{title} at #{company}"
  end # method label

  def title
    role.title.blank? ? content_tag(:span, '(none)', :class => 'light') : role.title
  end # method title
end # class
