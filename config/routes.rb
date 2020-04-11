Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: 'json' }, path: '/api' do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :users do
      put :confirm, on: :collection
    end
    resources :books do
      get 'by_name/:friendly_id', to: 'books#show', on: :collection
    end
    resources :my_books, only: [:index]
    resources :genres
    resources :book_activities

    resources :conversations, only: [:show] do
      resources :messages
    end

    resources :notifications do
      get :unread, on: :collection
      put :read, on: :collection
    end

    get 'metadata', to: 'metadata#index'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
