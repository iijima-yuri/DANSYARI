Rails.application.routes.draw do
  get 'genres/index'
  get 'genres/create'
  mount ActionCable.server => '/cable'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "static_pages#top"

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create show index] do
    member do
      get 'favorites'
      get 'follows', to: 'relationships#followings'
      get 'followers', to: 'relationships#followers'
    end
    resource :relationships, only: %i[create destroy]
  end

  resources :items do
    resources :comments, only: %i[create destroy]
    resource :favorites, only: %i[create destroy]
    get 'trashed', on: :collection, to: 'items#trashed_items'
    get 'stay', on: :collection, to: 'items#stay_items'
    get 'worry', on: :collection, to: 'items#worry_items'
    get 'all', on: :collection, to: 'items#all_items'

    get 'search_tag', to: 'items#search_tag'
    get 'search_genre', to: 'items#search_genre'
  end

  namespace :mypage do
    resource :profile, only: %i[show edit update]
    resources :profile_shows, only: %i[show]
  end

  resources :notifications, only: %i[index]

  resources :chat_rooms, only: %i[index show create destroy]

  resources :genres, only: %i[new index create]
end
