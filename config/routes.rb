Rails.application.routes.draw do

  root to: "articles#index"

  resources :journals do
    member do
      get "articles"
    end
  end
  devise_for :users
  resources :articles, :except => [:new] do
    member do
      get "new",:as => "new"
    end
  end
  resources :comments, :only => [:new,:create,:destroy]
 
end