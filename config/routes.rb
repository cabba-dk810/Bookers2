Rails.application.routes.draw do
	root 'root#home'
	get "home/about" => "root#about"
	resources :roots
  	devise_for :users

  	resources :users, only: [:show, :edit, :index, :update]
  	resources :books, only: [:create, :show, :index, :update, :edit, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
