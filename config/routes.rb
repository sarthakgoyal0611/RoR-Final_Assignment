Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles
  get 'signup' , to: 'users#new'
  post 'users' , to: 'users#create', as: :users
  get 'user/:id' , to: 'users#show', as: :user
end