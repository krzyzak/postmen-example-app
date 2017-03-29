Rails.application.routes.draw do
  resources :labels
  resources :rates
  resources :shipper_accounts

  root to: 'shipper_accounts#index'
end
