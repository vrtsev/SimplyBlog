Rails.application.routes.draw do
  root "home#index"

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "omniauth_callbacks" }

  # namespace :profile do
    resources :users, only: :index, module: 'profile' do
      resources :categories, only: :show
      resources :posts, only: [:index, :show] do
        resources :comments, except: :index
      end
    end
  # end

  # resources :users, only: :index
  resources :categories, except: :index
  resources :posts do
    resources :comments, except: :index
  end
end
