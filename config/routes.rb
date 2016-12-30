Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :categories
  resources :posts do
    resources :comments
  end
  get '/id:user', to: 'profile#index', as: 'profile'
  get '/id:user/posts/:id', to: 'profile#show', as: 'profile_post'
end
