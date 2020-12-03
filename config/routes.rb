Rails.application.routes.draw do
  root 'welcome#index'
  #user
  get '/registration', to: 'users#new'
  post '/registration', to: 'users#create'
  get '/dashboard', to: 'users#show'
  #session
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/discover', to: 'discover#index'

  post '/friendship', to: 'friendship#create'

  post '/party', to: 'party#create'
end
