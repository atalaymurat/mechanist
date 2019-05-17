Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users
  resources :people
  resources :companies

  root to: "pages#home"
end
