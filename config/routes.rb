Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Custom route for latest location
      get 'locations/latest', to: 'locations#latest'
      post 'alerts/download', to: 'alerts#download'
      resources :locations
      resources :alerts
      resources :alert_zones
      resources :parameters
    end
  end
     
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
