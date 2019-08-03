Rails.application.routes.draw do
	# root ''
  devise_for :users
  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  root :to => 'users#top'
  get 'home/about' => 'users#about'
  # patch 'books/id/edit' => 'books#update'
  # get 'users' => 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
