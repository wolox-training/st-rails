Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do 
      namespace :users do 
        mount_devise_token_auth_for 'User', at: 'auth'
        post 'sessions', to: 'sessions#create'
      end

    end
  end
end
