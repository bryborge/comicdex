# frozen_string_literal: true

Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  devise_for :users, controllers: {
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root 'static_pages#home'

  get 'setup', to: 'setup#new', as: 'setup'
  post 'setup', to: 'setup#create'

  namespace :users do
    resource :profile, only: %i[show edit update]
  end

  resources :users do
    member do
      get :collection
    end
  end

  resources :user_comicbooks, only: %i[create destroy]

  resources :series do
    resources :comicbooks
  end
end
