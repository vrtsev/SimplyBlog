Rails.application.routes.draw do

	root "posts#index"
  resources :posts do
  	resources :comments
  	get :likes
  end
  devise_for :users

  get ':controller(/:action(/:id))'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
