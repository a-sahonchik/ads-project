# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, path_prefix: 'my'
    resources :users

    get 'welcome/index'
    root 'welcome#index'

    resources :advertisements
    resources :categories

    get '/my_advertisements' => 'advertisements#user_advertisements', :as => :custom_user_advertisements
    get '/opened_advertisements' => 'advertisements#opened_advertisements', :as => :opened_advertisements
    match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  end
end
