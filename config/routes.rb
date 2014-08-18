# config/routes.rb

Rails.application.routes.draw do
  resources :roles, :only => %i(index new create show)

  root 'roles#index'
end # routes.draw
