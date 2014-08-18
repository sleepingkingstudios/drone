# config/routes.rb

Rails.application.routes.draw do
  resources :roles, :only => %i(index)

  root 'roles#index'
end # routes.draw
