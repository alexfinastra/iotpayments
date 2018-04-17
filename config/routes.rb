Rails.application.routes.draw do
  root :to => "payments#index"
  
  get '/contracts/iotbutton/', to: "contracts#iotbutton"
  get '/payments/confirmed/:pid', to: "payments#confirmed"
  get '/payments/notification/:pid', to: "payments#notification"
  
  resources :contracts
  resources :merchants
  resources :users
  resources :devices
  resources :payments
  resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end

