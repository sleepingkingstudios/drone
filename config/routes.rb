# config/routes.rb

Rails.application.routes.draw do
  resources :recruiters

  resources :roles do
    resources :events, :controller => 'role_events'
  end # resources

  root 'roles#index'
end # routes.draw
