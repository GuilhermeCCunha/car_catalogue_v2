Rails.application.routes.draw do
  get 'admin/dashboard'
  post 'admin/ban/:id', to: 'admin#ban_user', as: 'admin_ban_user'
  post 'admin/unban/:id', to: 'admin#unban_user', as: 'admin_unban_user'
  get 'account/profile'
  devise_for :users
  resources :brands
  resources :cars
  get 'welcome/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
