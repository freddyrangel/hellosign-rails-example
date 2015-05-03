Rails.application.routes.draw do
  root 'sessions#new'

  resources :sessions, only: [:new, :create, :destroy]
  resources :signature_requests do
    collection do
      post 'callbacks'
    end
  end
end
