Rails.application.routes.draw do
  namespace :admin do
      resources :questions
      resources :trainings
      resources :categories
      resources :voices
      resources :users

      root to: "questions#index"
    end
  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post 'guest_login', to: 'user_sessions#guest_login'
  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update]
  resources :categories
  resources :questions
  resources :trainings, only: %i[show new create destroy] do
    resources :voices, only: %i[create]
  end
end
