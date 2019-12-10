Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'my'
  resources :users

  get 'welcome/index'
  root 'welcome#index'

  resources :advertisements
  resources :categories

  get '/my_advertisements' => 'advertisements#user_advertisements', :as => :custom_user_advertisements
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
end
