Rails.application.routes.draw do
  root "pages#home"
  get "about", to: "pages#about"

  resources :cocktails, only: [ :index, :new, :show, :create, :edit, :update ] do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: [:destroy]
  # never nest the destroy route
  mount Attachinary::Engine => "/attachinary"
end
