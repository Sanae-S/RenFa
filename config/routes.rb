Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end
resources :users
put "/users/:id/hide" => "users#hide", as: 'users_hide'

root 'post_images#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
