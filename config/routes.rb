Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'authentication#index'
  post :login, to: 'authentication#login'

  resources :messaging, only: [:index, :create]

  mount ActionCable.server => '/stream'
end
