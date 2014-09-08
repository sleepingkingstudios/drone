# app/presenters/role_event_presenter.rb

class RoleEventPresenter < Presenter
  alias_method :event, :object

  def event_at
    event.event_at.blank? ? empty_value : event.event_at.to_time.strftime('%a, %d %B %Y at %l:%M%P')
  end # method event_at

  def notes
    event.notes.blank? ? empty_value : event.notes
  end # method notes

  def summary
    empty_value
  end # method summary

  def type
    if match = /\ARole(?<name>\w+)Event\z/.match(event.class.name)
      match[:name].underscore.split('_').map { |str| str.capitalize }.join(' ')
    else
      'Event'
    end # if-else
  end # method type

  private

  def empty_value
    content_tag(:span, '(none)', :class => 'light')
  end # method empty_value
end # class
