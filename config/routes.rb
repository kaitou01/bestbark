Rails.application.routes.draw do
  root to: 'products#index'

  get 'category/:id', to: 'products#show_by_category', as: 'category', id: /\d+/

  get 'product/:id', to: 'products#show', as: 'product', id: /\d+/

  get 'about', to: 'pages#about', as: 'about'

  get 'contact', to: 'pages#contact', as: 'contact'

  get 'shopping-cart', to: 'products#load_shopping_cart', as: 'cart'

  post 'update-quantity', to: 'products#update_item', as: 'update_item'

  resources :products, only: [:show] do
    member do
      post :add_to_cart
      post :remove_item_from_cart
    end
    collection do
      post :empty_cart
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
