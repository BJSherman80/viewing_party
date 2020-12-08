Rails.application.routes.draw do
  root 'welcome#index'
  #user
  get '/registration', to: 'users#new'
  post '/registration', to: 'users#create'
  get '/dashboard', to: 'users#show'
  #session
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/discover', to: 'discover#index'

  get '/movies', to: 'movies#index'
  get '/movies/search', to: 'movies#search'
  get '/movies/:id', to: 'movies#show'

  post '/friendship', to: 'friendship#create'

  post '/party', to: 'party#create'
end
