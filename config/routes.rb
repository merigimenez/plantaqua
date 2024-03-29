Rails.application.routes.draw do
  require "sidekiq/web"

  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "pages#home"
  resources :users, only: :show
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :gardens do
    resources :garden_plants, only: %i[index show new create]
  end

  resources :garden_plants, only: %i[destroy edit update] do
    member do
      patch :water
    end
  end

  resources :user_gardens, only: %i[destroy]

  resources :plants, only: %i[index show]
  resources :notifications, only: %i[index]
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # authenticate :user, ->(user) { user.admin? } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end
end
