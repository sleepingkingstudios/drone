# app/presenters/role_interview_event_presenter.rb

class RoleInterviewEventPresenter < RoleEventPresenter
  def select_options_for_subtype
    RoleInterviewEvent::SUBTYPES.map do |value|
      [present_subtype(value), value]
    end # map
  end # method select_options_for_subtype  

  def type
    event.subtype? ? "#{present_subtype(event.subtype)} Interview" : 'Interview'
  end # method type

  private

  def present_subtype value
    value.split('_').map(&:capitalize).join(' ')
  end # method present_subtype
end # class
