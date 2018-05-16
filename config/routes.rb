Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' },
  path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  as :user do
    get 'login', to: 'devise/sessions#new'
  end

  resources :groups do
    post 'join', to: 'memberships#create'
    delete 'leave', to: 'memberships#destroy'

    get 'members', to: 'members#index'

    resources :events do
      resources 'organizers', only: [:create, :delete]
    end
  end

  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  root 'landing#index'
end
