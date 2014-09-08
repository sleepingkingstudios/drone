# app/helpers/application_helper.rb

module ApplicationHelper
  def present object
    klass = object.class

    while klass != Object && klass != nil
      begin
        presenter = "#{klass.name}Presenter".constantize

        return presenter.new(object)
      rescue NameError => exception
        klass = klass.superclass
      end # begin-rescue
    end # while

    Presenter.new(object)
  end # method present
end # module ApplicationHelper
