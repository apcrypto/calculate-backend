Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, :journeys
      post 'signin', to: 'users#signin'
      get 'validate', to: 'users#validate'
      get 'journey', to: 'users#get_journey'

      post 'journey_info', to: 'journeys#journey_info'
    end
  end
end
