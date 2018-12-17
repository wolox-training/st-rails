class ApiV1Controller < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Wor::Paginate
  include Pundit
  protect_from_forgery with: :null_session
  before_action :authenticate_api_v1_users_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

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

  def record_invalid(exception)
    render json: {
      errors: exception.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  def not_authorized
    render json: {
      errors: 'You are not authorized to perform this action'
    }, status: :forbidden
  end

  def pundit_user
    current_api_v1_users_user
  end
end
