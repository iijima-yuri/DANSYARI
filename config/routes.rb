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

  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'privacy_policy', to: 'static_pages#privacy_policy'

  resources :contacts, only: %i[new create] do
    collection do
      post 'confirm', to: 'contacts#confirm', as: 'confirm'
      post 'back', to: 'contacts#back', as: 'back'
      get 'done', to: 'contacts#done', as: 'done'
    end
  end

  resources :users, only: %i[new create] do
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
    get 'trashed', on: :member, to: 'items#trashed_items'
    get 'stay', on: :member, to: 'items#stay_items'
    get 'worry', on: :member, to: 'items#worry_items'
    get 'all', on: :collection, to: 'items#all_items'

    get 'search_tag', to: 'items#search_tag'
    get 'search_genre', to: 'items#search_genre'
    collection do
      get 'search', to: 'items#search', as: :search
    end
    get 'autocomplete', on: :collection, to: 'items#autocomplete'
    get 'private_item_list', on: :collection, to: 'items#private_items'
  end

  namespace :mypage do
    resource :profile, only: %i[show edit update]
    resources :profile_shows, only: %i[show]
  end

  resources :notifications, only: %i[index]

  resources :chat_rooms, only: %i[show create] do
    collection do
      get 'entrance', to: 'chat_rooms#entrance'
    end
  end

  resources :genres, only: %i[new index create]
end
