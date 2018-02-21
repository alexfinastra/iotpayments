Rails.application.routes.draw do
  #resources :contracts
  #resources :merchants
  #resources :users
  #resources :devices
  #resources :payments
  #resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "payments#index"
  
  get '/contracts/button', to: "contracts#button"
  post '/contracts/buttontest1', to: "contracts#button_registration"
end

