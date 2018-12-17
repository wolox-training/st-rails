Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  api_version(module: "api/v1", path: {value: "api/v1"}) do
    resources :books,  only: [:index, :show]

    resources :users, only: :none do
      resources :rents,  only: [:index, :create]
    end

    namespace :users do 
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end

end
