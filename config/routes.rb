Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :users, only: [:create, :show, :update] do
        resources :badges, only: [:index]
        resources :activities, only: [:index]
      end
      
      resources :activities, only: [:create, :show]
    end
  end
  
  get '/api/v1/breweries/:user_id', to: 'api/v1/breweries#search'
  get '/api/v1/leaderboard', to: 'api/v1/users#leaderboard'
  get '/api/v1/gas_price/:user_id', to: 'api/v1/gas_prices#show'
end
