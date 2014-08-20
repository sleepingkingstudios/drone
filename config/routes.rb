# config/routes.rb

Rails.application.routes.draw do
  resources :roles

  root 'roles#index'
end # routes.draw
