Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/dashboard", to: "pages#dashboard", as: :dashboard

  get "up" => "rails/health#show", as: :rails_health_check

  resources :skills, only: [:index, :show, :new, :edit, :update, :create] do
    resources :bookings, only: [:new, :create, :update]
  end

  resources :bookings, only: [:show] do
    resources :reviews, only: [:create]
  end

  resources :chatrooms, only: [:show] do
    resources :messages, only: :create
  end
  
  resources :skills, only: [:destroy], as: :destroy_skill
  resources :bookings, only: [:destroy]
  resources :reviews, only: [:destroy]

  patch "/booking/:id", to: "booking#status_update", as: :status_update

  resources :chatrooms, only: [:index, :show]  # This allows for index and show without a booking_id

end
