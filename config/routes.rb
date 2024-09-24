Rails.application.routes.draw do
  resources :patients do
    collection do
      get :statistics  # Adding the route for the statistics action
    end
  end

  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root 'sessions#new'  # Redirect to login page
end
