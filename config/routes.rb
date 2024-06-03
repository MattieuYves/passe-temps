Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/dashboard", to: "pages#dashboard", as: :dashboard


  get "up" => "rails/health#show", as: :rails_health_check


  resources :skills, only: [:index, :show, :new, :edit, :create] do
    resources :sessions, only: [:new, :create]
  end

  resources :sessions, only: [] do
    resources :reviews, only: [:create]
    resources :chatrooms, only: :show do
      resources :messages, only: :create
    end
  end

  resources :skills, only: [:destroy]
  resources :sessions, only: [:destroy]
  resources :reviews, only: [:destroy]

  patch "/session/:id", to: "session#status_update", as: :status_update

end
