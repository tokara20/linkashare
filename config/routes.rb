Rails.application.routes.draw do
  devise_for :users
  
  resources :links do
    get 'mylinks', to: "links#my_links", as: :my, on: :collection
    member do
      get 'approve-link', to: "links#approve_link", as: "approve"
      get 'unapprove-link', tp: "links@unapprove_link", as: "unapprove"
    end
  end
  
  resources :user, only: [:show]
  
  root to: "links#index"
  
  get 'about' => 'pages#about', as: :about
end
