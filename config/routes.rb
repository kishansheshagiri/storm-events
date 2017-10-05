Rails.application.routes.draw do
  get 'episodes/home'

  get 'episodes/events'

  get 'episodes/help'

  get 'episodes/about'

  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "episodes#home"
end
