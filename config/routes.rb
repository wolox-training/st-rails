Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  api_version(module: "api/v1", path: {value: "api/v1"}) do
    resources :books,  only: [:index, :show]

    scope 'users/:user_id' do
      resources :rents,  only: [:index, :create]
    end

    namespace :users do 
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end

end
