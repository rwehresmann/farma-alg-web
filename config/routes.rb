Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'user_token', to: 'user_token#create'
    
      resources :exercises
      resources :questions
    end
  end
end
