Rails.application.routes.draw do
  resource :session, only: [:create, :destroy]

  resources :users, only: [:index]
  resource :profile, only: [:create, :show]
end
