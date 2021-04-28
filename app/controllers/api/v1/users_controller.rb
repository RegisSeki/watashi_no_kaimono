module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all

        render json: users, status: :ok
      end

      def create
        begin
          user = User.new(user_params)

          user.save!
          UserMailer.with(user: user).validation_email.deliver_later
          render json: user, status: :created
        rescue => e
          render json: e.message, status: :unprocessable_entity
        end
      end

      def destroy
        User.find(params[:id]).destroy

        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
      end
    end
  end
end
