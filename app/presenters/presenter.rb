# app/presenters/presenter.rb

class Presenter
  include ActionView::Helpers

  def initialize object
    @object = object
  end # constructor

  attr_reader :object  
end # class
