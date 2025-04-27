Rails.application.routes.draw do

  # config/routes.rb
namespace :admin do
  get "dashboard", to: "dashboard#index", as: "dashboard"
end

  # Sessions (Login/Logout)
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  # User signup
  get "/signup", to: "users#new", as: "signup"
  post "/signup", to: "users#create"
  
  get "carts/show"
  get "carts/add"
  get "carts/update"
  get "carts/remove"
  get "products/index"
  get "products/show"
  
  root "pages#home"
   
  
  resources :products, only: [:index, :show]

  # config/routes.rb
namespace :admin do
  get 'dashboard', to: 'dashboard#dashboard'
  resources :products
end

  get "/cart", to: "carts#show", as: "cart"
  post "/cart/add/:id", to: "carts#add", as: "add_to_cart"
  post "/cart/update/:id", to: "carts#update", as: "update_cart"
  get "/cart/remove/:id", to: "carts#remove", as: "remove_from_cart"

  get 'about', to: 'pages#show', defaults: { name: 'about' }
  get 'contact', to: 'pages#show', defaults: { name: 'contact' }
  get '/pages/:name', to: 'pages#show', as: 'page'

  get '/admin/pages/edit', to: 'pages#edit', as: 'edit_pages'
  patch '/admin/pages/:id', to: 'pages#update', as: 'update_page'


  resources :orders, only: [:index, :show]  #
  get '/checkout', to: 'checkout#new', as: 'checkout'
  post '/checkout', to: 'checkout#create'
  


end
