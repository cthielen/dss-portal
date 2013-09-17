DssPortal::Application.routes.draw do
  resources :application_assignments, :path => "/" do
    collection do
      post 'drag_update'
    end
  end

  root :to => 'application_assignments#index'
end
