Rails.application.routes.draw do
  root 'home#index'
  get '/registration/new', to: 'registrations#new', as: 'new_registration'
  post '/registration', to: 'registrations#create', as: 'registration'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
