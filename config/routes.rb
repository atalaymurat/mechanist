Rails.application.routes.draw do
  get 'emails/index'
  get 'pages/home'
  devise_for :users
  resources :people
  resources :companies
  
  namespace :dynamic_select do
    get ':country_id/states', to: 'states#index', as: 'states'
  end

  root to: "pages#home"
end
