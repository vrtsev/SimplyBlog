Rails.application.routes.draw do
  root "posts#index"

  devise_for :users

  resources :diaries
  resources :posts do
    resources :comments
  end

  get '/my_posts', to: 'posts#my_posts'
  get '/my_comments', to: 'posts#my_comments'
  get '/about', to: 'posts#about'
  scope 'admins' do
    get '/index', to: 'admins#index'
    get '/posts', to: 'admins#posts'
    get '/users', to: 'admins#users'
    get '/history', to: 'admins#history'
    delete '/history/clear', to: 'admins#clear_history'
    delete '/posts/:id', to: 'admins#post_destroy'
    resources :warnings do 
      put :set_public, on: :member
    end
  end
end
