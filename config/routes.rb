Rails.application.routes.draw do
  root 'movies#index'
  devise_for :users

  resources :movies do
    get :follow, on: :member
    get :unfollow, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
