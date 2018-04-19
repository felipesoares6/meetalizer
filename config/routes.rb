Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' },
  path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  as :user do
    get 'login', to: 'devise/sessions#new'
  end

  resources :groups, only: [:index, :new, :create, :edit, :update, :show, :destroy] do
    resources :memberships, only: [:create]
    resources :users, only: [:index]
  end

  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  root 'landing#index'
end
