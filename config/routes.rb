Rails.application.routes.draw do
  get 'dashboard/index'

  scope '/admin' do
    resources :articles
    resources :accounts
  end

  get 'gym_membership/join_now'
  post 'gym_membership/checkout'

  devise_for :users

  root "dashboard#index"

  post '/contact_messages', to: 'contact_messages#create'
  get 'payments/index'
  post 'payments/checkout'

end
