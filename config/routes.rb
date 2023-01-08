Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :users, only: [:create, :show, :update]
      resources :activities, only: [:create]
    end
  end
  
  get 'api/v1/breweries/:user_id', to: 'api/v1/breweries#search'

  get 'api/v1/activities/:user_id', to: 'api/v1/activities#index'
  get 'api/v1/activities/:user_id/:activity_id', to: 'api/v1/activities#show'
end
