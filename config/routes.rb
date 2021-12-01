Rails.application.routes.draw do
  root 'home#index'
  get '/test', to: 'home#test', as: 'test'
  get '/registration/new', to: 'registrations#new', as: 'new_registration'
  post '/registration', to: 'registrations#create', as: 'registration'
  get '/session/new', to: 'sessions#new', as: 'new_session'
  post '/session', to: 'sessions#create', as: 'session'
  resources :invoices
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
