DssPortal::Application.routes.draw do
  resources :application_assignments, :path => "/"
  resources :people
  root :to => 'application_assignments#index'
end
