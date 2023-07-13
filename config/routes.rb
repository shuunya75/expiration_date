Rails.application.routes.draw do
  devise_for :users

  root to: 'foods#index'

  resources :foods

  resource :profile, only: %i[show edit update] do
    collection do
      get 'search'
    end
  end

  resources :accounts, only: %i[show] do
    resources :follows, only: %i[create destroy]
  end
end
