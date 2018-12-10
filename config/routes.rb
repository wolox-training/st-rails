Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  api_version(:module => "api/1", :path => {:value => "api/v1"}) do
    namespace :users do 
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end

end
