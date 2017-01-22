Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  #Profile routes
  resources :users do
    resource :profile
  end
  #Jobs routes
  resources :users do
    resources :jobs
  end
  
  
  get 'about', to: 'pages#about'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end
