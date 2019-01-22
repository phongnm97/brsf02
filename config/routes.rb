Rails.application.routes.draw do
  devise_for :users
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    namespace :admin do
      root to: "users#index"
      resources :books
      resources :categories
      resources :users
    end
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    resources :likes
    resources :comments
    resources :books
    resources :book_statuses
    resources :book_favorites
    resources :reviews
    resources :relationships, only: [:create, :destroy]
    resources :users, only: [:show, :index]
  end
end
