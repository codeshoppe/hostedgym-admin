Rails.application.routes.draw do
  root "articles#index"
  resources :articles

  post '/contact_messages', to: 'contact_messages#create'
end
