Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "cocktails#index"

  resources :cocktails, only: [ :index, :new, :show, :create, :edit, :update ] do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: [:destroy]
  # never nest the destroy route
  mount Attachinary::Engine => "/attachinary"
end
