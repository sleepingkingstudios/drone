# app/presenters/presenter.rb

class Presenter
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  def initialize object
    @object = object
  end # constructor

  attr_reader :object  
end # class
