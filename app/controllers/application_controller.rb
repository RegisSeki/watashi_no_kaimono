class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token
	rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  def authenticate_user
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode(token)
    User.find(user_id)
  rescue
    render status: :unauthorized
  end

	private

	def not_destroyed(e)
  		render json: { errors: e.record }, status: :unprocessable_entity
  	end
end
