Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  root "pages#show", title: "home"

  get "/pages/*title", to: "pages#show"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, except: :destroy
  resources :books, only: [:index, :show]
  resources :relationships, only: [:index, :create, :destroy]
  resources :favorite_books, only: [:create, :destroy]
  resources :requests, except: :show
  resources :reviews, except: :index
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :reports, only: :create
  resources :activities, only: :index
  resources :categories, only: :show

  namespace :admins do
    resources :categories, except: :new
    resources :books
    resources :requests, only: [:index, :update, :destroy]
    resources :reports, only: [:index, :destroy]
  end
end
