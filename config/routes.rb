Rails.application.routes.draw do
  get 'gym_membership/join_now'
  post 'gym_membership/checkout'

  devise_for :users

  root "articles#index"
  resources :articles

  post '/contact_messages', to: 'contact_messages#create'
  get 'payments/index'
  post 'payments/checkout'

end
