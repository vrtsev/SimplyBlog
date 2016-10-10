Rails.application.routes.draw do

  resources :diaries
  # resources :warnings
	root "posts#index"
  resources :posts do
  	resources :comments
  	get :likes
  end
  resources :diaries 
  devise_for :users
  get '/my_posts', to: 'posts#my_posts'
  get '/my_comments', to: 'posts#my_comments'
  get '/about', to: 'posts#about'
  scope 'admins' do
    get '/index', to: 'admins#index'
    get '/posts', to: 'admins#posts'
    get '/users', to: 'admins#users'
    get '/history', to: 'admins#history'
    delete '/history/clear', to: 'admins#clear_history'
    resources :warnings do 
      put :set_public, on: :member
    end
  end

  # get ':controller(/:action(/:id))'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
