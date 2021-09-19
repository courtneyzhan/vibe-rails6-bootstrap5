Rails.application.routes.draw do
  resources :moods
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

   get 'errors/404' => 'errors#error_404'
   get 'errors/422' => 'errors#error_500'
   get 'errors/500' => 'errors#error_500'
   get "errors/403" => 'errors#error_403' # don't throw error, just redirect home page with alert  

  get 'dashboard' => "welcome#dashboard", :as => "dashboard"

  root to: 'welcome#index'

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "sign-in" => "sessions#new", :as => "sign-in"
  get "sign-out" => "sessions#destroy", :as => "sign-out"
  get "sign-up" => "users#new", :as => "sign-up"

  if Rails.env != "au" 
    get "reset" => "reset#index"
  end
  
  get "posts/:id/delete" => "posts#destroy"
  get "search" => "posts#index", :as => "get-search"
  post "search" => "posts#search", :as => "search"
  get "calendar" => "calendar#index"  

  resources :sessions
  resources :users
  resources :posts
  
end
