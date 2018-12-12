class ApiV1Controller < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Wor::Paginate
  protect_from_forgery with: :null_session
  before_action :authenticate_api_v1_users_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  def record_not_found
    render json: {
      'errors': [
        'Record not found'
      ]
    }, status: :not_found
  end

  def parameter_missing(exception)
    render json: {
      'errors': [
        exception.message
      ]
    }, status: :bad_request
  end
end
