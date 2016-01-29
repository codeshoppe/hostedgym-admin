Rails.application.routes.draw do
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

  get 'dashboard/index'
  root "dashboard#index"
end
