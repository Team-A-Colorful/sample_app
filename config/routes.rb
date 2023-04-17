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
  resource :customers, only: [] do
    resource :information, only: [:show, :edit, :update]
    get 'withdraw' => 'customers#withdraw'
    patch 'resign' => 'customers#resign'
  end

  resources :cart_items, only: [:index, :update, :destroy, :create] do
    post 'destroy_all' => 'cart_items#destroy_all'
  end
  resources :orders, only: [:new, :create, :index, :show] do
    get 'confirm' => 'orders#confirm'
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
