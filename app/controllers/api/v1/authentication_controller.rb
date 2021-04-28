module Api
  module V1
    class AuthenticationController < ApplicationController
      class AuthenticationError < StandardError; end

      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from AuthenticationError, with: :handle_unaunthenticated

      def create
        begin
          raise AuthenticationError unless user.authenticate(params.require(:password))

          token = AuthenticationService.encode_token(user.id)

          render json: { token: token }, status: :created
        rescue
          render json: 'Check your credentials', status: :unauthorized
        end
      end

      def refresh
        new_token = AuthenticationService.refresh_token(params['token'])

        render json: { token: new_token }, status: :created
        rescue
          render status: :unauthorized
      end

      private

      def user
        @user = User.find_by(username: params.require(:username))
      end

      def parameter_missing(e)
        render json: { error: e.message }, status: :unprocessable_entity
      end

      def handle_unaunthenticated
        head :unauthorized
      end
    end
  end
end
