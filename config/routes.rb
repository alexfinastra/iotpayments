Rails.application.routes.draw do
  #resources :contracts
  #resources :merchants
  #resources :users
  #resources :devices
  #resources :payments
  #resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "payments#index"
  
  get '/contracts/iotbutton', to: "contracts#iotbutton"
end

