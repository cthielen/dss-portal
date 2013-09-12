DssPortal::Application.routes.draw do
  resources :application_assignments

  resources :application_assignments do
    collection do
      post 'drag_update'
    end
  end

  resources :application_assignments do
    collection do
      post 'create_or_update'
    end
  end

  match '/manage', to: 'application_assignments#manage'

  root :to => 'application_assignments#index'
end
