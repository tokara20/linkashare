Rails.application.routes.draw do
  devise_for :users
  
  resources :links do
    get 'mylinks', to: "links#my_links", as: :my, on: :collection
  end
  
  resources :user, only: [:show]
  
  root to: "links#index"
  
  get 'about' => 'pages#about', as: :about
end
