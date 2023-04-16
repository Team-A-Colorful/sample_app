Rails.application.routes.draw do
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

scope module: :public do
    resources :items
    resources :customers do
      get 'withdraw' => 'customers#withdraw'
      patch 'resign' => 'customers#resign'
    end
    resources :cart_items
    post 'cart_items' => 'cart_items#destroy_all'
    resources :orders
    resources :shipping_addresses
  end
  namespace :public do
    get 'orders/log'
    get 'orders/completed'
  end

  namespace :admin do
    resources :items
    resources :customers
    resources :genres
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
