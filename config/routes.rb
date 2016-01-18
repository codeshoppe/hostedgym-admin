Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  resources :articles

  post '/contact_messages', to: 'contact_messages#create'
end
