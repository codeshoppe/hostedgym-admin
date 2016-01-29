Rails.application.routes.draw do
  resources :clinics
  get 'dashboard/index'

  scope '/admin' do
    resources :articles
    resources :accounts
    resources :clinics
  end

  resource :membership, only: [:new, :create, :show]
  get 'join_now', to: 'memberships#new', as: :join_now

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root "dashboard#index"

  post '/contact_messages', to: 'contact_messages#create'
end
