Rails.application.routes.draw do
  namespace :api do
    resources :appointments , except: [:new,:edit]
  end
  
  root 'appointments#index'
  
  
  resources :appointments
end
