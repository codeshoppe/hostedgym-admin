Rails.application.routes.draw do
  get 'welcome/index'

  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: :dashboard
  end

  scope '/admin' do
    resources :articles
    resources :accounts
    resources :clinics
  end

  resources :clinics

  resource :membership, only: [:new, :create, :show]
  get 'join_now', to: 'memberships#new', as: :join_now

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  authenticated :user do
    root :to => "dashboard#index", as: :authenticated_root
  end

  get 'dashboard', to: 'dashboard#index', as: :dashboard

  get 'welcome', to: 'welcome#index', as: :welcome


  root to: 'welcome#index'

end
