Rails.application.routes.draw do
  # get 'chats/show'
  resources :chats, only: [:create, :show]
	# root ''
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  resources :users, only: [:show, :edit, :update, :index] do
  	member do
  		get :following, :followers
  	end
  end
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
  	resource :comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end
  root :to => 'users#top'
  get 'home/about' => 'users#about'

  resources :relationships, only: [:create, :destroy]
  # patch 'books/id/edit' => 'books#update'
  # get 'users' => 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
