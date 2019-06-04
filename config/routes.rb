Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'user_token', to: 'user_token#create'
    
      resources :teams
      resources :exercises
      resources :questions do
        resources :test_cases, shallow: true
      end
    end
  end
end
