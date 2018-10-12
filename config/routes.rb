Rails.application.routes.draw do
  devise_for :users, path: 'auth'

  get 'profile', to: 'profile#index', as: 'user_root'

  get 'events', to: 'events#index'
  post 'events', to: 'events#create'
  get 'events/new', to: 'events#new'
  get 'events/:id', to: 'events#show', as: 'event'
end
