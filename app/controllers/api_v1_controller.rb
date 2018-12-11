class ApiV1Controller < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Wor::Paginate
  protect_from_forgery with: :null_session
  before_action :authenticate_api_v1_users_user!
end
