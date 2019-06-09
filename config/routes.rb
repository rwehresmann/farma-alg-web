Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'user_token', to: 'user_token#create'
    
      resources :teams
      resources :exercises do
        get '/questions', to: 'exercise_questions#index', as: :questions
        post '/questions/:question_id', to: 'exercise_questions#create'
        delete '/questions/:question_id', to: 'exercise_questions#destroy'
      end
      resources :questions do
        resources :test_cases, shallow: true
      end
    end
  end
end
