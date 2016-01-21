Rails.application.routes.draw do
  get 'dashboard/index'

  scope '/admin' do
    resources :articles
    resources :accounts
  end

  resource :membership#, only: [:new, :create, :show]

  get 'join_now', to: 'memberships#new', as: :join_now


  devise_for :users

  root "dashboard#index"

  post '/contact_messages', to: 'contact_messages#create'
  get 'payments/index'
  post 'payments/checkout'

end
