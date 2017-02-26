Rails.application.routes.draw do
  devise_for :users
  
  resources :links do
    collection do
      get 'my-links', to: "links#my_links", as: :my
      get 'my-approved-links', to: "links#my_approved_links",
          as: :my_approved
    end
    
    member do
      post 'approve-link', to: "links#approve_link", as: "approve"
      delete 'unapprove-link', to: "links#unapprove_link", as: "unapprove"
    end
    
    resources :comments, only: [:create, :destroy]
  end
  
  resources :user, only: [:show]
  
  root to: "links#index"
  
  get 'about' => 'pages#about', as: :about
end
