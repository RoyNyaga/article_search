Rails.application.routes.draw do
  root "articles#index"
  resources :articles
  devise_for :users
  get "search", to: "search#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
