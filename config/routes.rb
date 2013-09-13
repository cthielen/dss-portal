DssPortal::Application.routes.draw do
  resources :people
  resources :application_assignments do
    collection do
      post 'drag_update'
    end
  end

  root :to => 'application_assignments#index'
end
