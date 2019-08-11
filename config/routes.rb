Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'user_token', to: 'user_token#create'

      resources :teams do
        get '/exercises', to: 'team_exercises#index', as: :exercises
        post '/exercises/:exercise_id', to: 'team_exercises#create'
      end
      
      resources :exercises do
        get '/questions', to: 'exercise_questions#index', as: :questions
        post '/questions/:question_id', to: 'exercise_questions#create'
        delete '/questions/:question_id', to: 'exercise_questions#destroy'
      end

      resources :questions do
        resources :test_cases, shallow: true
      end

      resources :team_exercises, only: %i[show destroy update]
    end
  end
end
