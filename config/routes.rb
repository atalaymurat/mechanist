Rails.application.routes.draw do
  
  get 'connecteds/destroy'
  devise_for :users
  resources :users, only: [:index, :edit, :update, :show, :destroy]
  resources :connecteds, only: :destroy


  get 'emails/index'
  get 'pages/home'
  get :search, controller: :pages


  resources :people do
    collection do
      get :import
      post :import
    end
  end
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end
  resources :companies, concerns: :paginatable do
    collection do
      get :import
      post :import
    end
  end
  
  namespace :dynamic_select do
    get ':country_id/states', to: 'states#index', as: 'states'
  end
  

  root to: "pages#home"
end
