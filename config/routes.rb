Rails.application.routes.draw do
  root 'episodes#home'
  get '/events', to: 'events#index'
  get '/help', to: 'episodes#help'
  get '/about', to: 'episodes#about'
  get '/contact', to: 'episodes#contact'

  resources :events
end
