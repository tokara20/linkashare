Rails.application.routes.draw do
  devise_for :users
  
  resources :links
  
  resources :user, only: [:show]
  
  root to: "links#index"
  
  get 'about' => 'pages#about', as: :about
end
