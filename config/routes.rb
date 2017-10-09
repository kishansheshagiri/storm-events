Rails.application.routes.draw do
  get 'users/show'

  get 'users/new'

  root 'episodes#home'
  get '/events', to: 'events#index'
  get '/get_counties_dropdown', to: 'events#counties_for_state', defaults: { format: 'js' }
  get '/help', to: 'episodes#help'
  get '/about', to: 'episodes#about'
  get '/contact', to: 'episodes#contact'
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  resources :events
  resources :episodes
  resources :users
end
