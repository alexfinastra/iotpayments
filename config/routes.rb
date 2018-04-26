Rails.application.routes.draw do
  root :to => "payments#index"
  
  get '/contracts/iotbutton/', to: "contracts#iotbutton"
  post '/contracts/sns_confirm/', to: "contracts#sns_confirm"
  post '/contracts/iotbutton/', to: "contracts#sns_confirm"
  post '/contracts/ecommerce/', to: "contracts#ecommerce"
  get '/contracts/payconfirm/', to: "contracts#payconfirm"
  get '/payments/confirmed/:pid', to: "payments#confirmed"
  get '/payments/notification/:pid', to: "payments#notification"
  get '/payments/purchase', to: "payments#purchase"
  get '/payments/confirm_loan/:pid', to: "payments#confirm_loan"
  get '/payments/loan/:pid', to: "payments#loan"

  resources :contracts
  resources :merchants
  resources :users
  resources :devices
  resources :payments
  resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end

