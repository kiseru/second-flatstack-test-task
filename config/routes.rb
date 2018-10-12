Rails.application.routes.draw do
  devise_for :users, path: 'auth'

  get 'profile', to: "profile#index"
end
