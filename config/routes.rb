MusicStore::Application.routes.draw do
  resources :product_types

  resources :videos

  resources :stores

  resources :songs

		#match albuns
  resources :products

  resources :reviews

  resources :bands

  resources :artists

  resources :genres

  resources :posts

  match "/home" => "home#index"
  match "/locator" => "stores#locator"
  match "/catalogue" => "products#catalogue"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  devise_for :users
  resources :users, :only => [:show, :index]

  mount Ckeditor::Engine => '/ckeditor'
end
