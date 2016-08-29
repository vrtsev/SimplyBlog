Rails.application.routes.draw do

  # resources :warnings
	root "posts#index"
  resources :posts do
  	resources :comments
  	get :likes
  end
  devise_for :users
	get '/my_posts', to: 'posts#my_posts'
  get '/about', to: 'posts#about'
  scope 'admins' do
    resources :warnings
  end

  get ':controller(/:action(/:id))'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
