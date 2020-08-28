Rails.application.routes.draw do

  get 'homes/about'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

root 'post_images#index'

resources :users do
  put "/hide" => "users#hide", as: 'hide'
end
get '/users/:user_id/post_images'=> 'post_images#user_posts', as:'user_posts'


resources :post_images do
  resources :comments, only: [:create, :destroy]
  resource :favorites, only: [:create, :destroy]
end
root 'post_images#index'

resources :categories, only: [:index]

namespace :admin do #管理者のみカテゴリー追加編集、会員の退会処理を行うため
  resources :categories
  resources :users
end
#カテゴリーによって絞り込んだ投稿を表示するアクションへのルーティング
get '/category/:category_id/post_images'=> 'post_images#category', as:'category_post_items'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

resources :rooms, only: [:index, :create, :show]
resources :messages, only: [:create, :update, :destroy]

#タグによって絞り込んだ投稿を表示するアクションへのルーティング
  resources :tags do
    get 'post_images', to: 'post_images#search'
  end
#ユーザーごとの投稿一覧用
get "search" => "users#search"
end
