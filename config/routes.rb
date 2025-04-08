Rails.application.routes.draw do
  get "carts/show"
  get "carts/add"
  get "carts/update"
  get "carts/remove"
  get "products/index"
  get "products/show"
  
 
  root "pages#home"
  get 'about', to: 'pages#about'
  resources :products, only: [:index, :show]


  get "/cart", to: "carts#show", as: "cart"
  post "/cart/add/:id", to: "carts#add", as: "add_to_cart"
  post "/cart/update/:id", to: "carts#update", as: "update_cart"
  get "/cart/remove/:id", to: "carts#remove", as: "remove_from_cart"



 
  
  
  
  

end
