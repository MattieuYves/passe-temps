Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"
  get "/dashboard", to: "pages#dashboard", as: :dashboard


  get "up" => "rails/health#show", as: :rails_health_check


  resources :skills, only: [:index, :show, :new, :edit, :create] do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [] do
    resources :reviews, only: [:create]
    resources :chatrooms, only: :show do
      resources :messages, only: :create
    end
  end

  resources :skills, only: [:destroy]
  resources :bookings, only: [:destroy]
  resources :reviews, only: [:destroy]

  patch "/booking/:id", to: "booking#status_update", as: :status_update

end
