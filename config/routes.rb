Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

scope module: :public do
  root 'homes#top'
  get 'about' => 'homes#about'
  resources :items, only: [:index, :show]
  get 'customers/infomation' => 'customers#show'
  get 'customers/infomation/edit' => 'customers#edit'
  patch 'customers/infomation' => 'customers#update'
  get 'customers/withdraw' => 'customers#withdraw'
  patch 'customers/resign' => 'customers#resign'
  resources :cart_items, only: [:index, :update, :destroy, :create]
  post 'cart_items/destroy_all' => 'cart_items#destroy_all'
  resources :orders, only: [:new, :create, :index, :show] do
    get 'log' => 'orders#log'
    get 'completed' => 'orders#completed'
  end
  resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]
end

  namespace :admin do
    root 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :orders_items, only: [:update]
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
