Rails.application.routes.draw do
  resource :session, only: [:create, :destroy]

  resources :profiles, only: [:create, :show]
end
