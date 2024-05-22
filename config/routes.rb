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

  namespace :users do
    resource :profile, only: %i[show edit update]
  end

  resources :users do
    member do
      get :comicbooks
    end
  end

  resources :user_comicbooks, only: %i[create destroy]

  root 'static_pages#home'

  resources :comicbooks
end
