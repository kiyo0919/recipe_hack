Rails.application.routes.draw do
  namespace :public do
    get 'searches/search'
  end
  # URL /customers/sign_in ...
devise_for :users,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  resources :genres, only: [:index, :edit, :create, :update, :destroy]
end

scope module: :public do
  root to: 'homes#top'
  get '/about' => 'homes#about', as: 'about'
  resources :recipes do
    resource :favorites, only: [:create, :destroy]
    resources :recipe_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :index, :edit, :update] do
    resources :stock_foods, only: [:index, :create, :destroy]
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  get 'searches' => 'searches#search', as: 'searches'
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
