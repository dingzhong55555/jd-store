Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'

  namespace :admin do
    resources :products
    resources :orders
  end

  resources :products  do
    member do
      post :add_to_cart
      post :like
      delete :unlike
    end
    collection do
      get :search
    end

    resources :comments
  end

  resources :carts do
    collection do
      post :checkout
      delete :clean
    end
  end

  resources :cart_items do
    member do
      post :add_quantity
      post :reduce_quantity
    end
  end

  namespace :account do
    resources :likes
    resources :orders
  end

  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
    end
  end
end
