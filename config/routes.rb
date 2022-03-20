Rails.application.routes.draw do
  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resources :categories
  resources :questions
  resources :trainings, only: %i[show create] do
    resources :voices, only: %i[create]
    collection do
      get 'new_graduate'
      get 'job_change'
      get 'engineer'
    end
  end
end
