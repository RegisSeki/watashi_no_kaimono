module Api
  module V1
    class ShoppingListsController < ApplicationController
      before_action :authenticate_user, only: [:index, :create]

      def index
        shopping_lists = ShoppingList.load_opened_lists(@current_user_id)
        render json: ShoppingListsRepresenter.new(shopping_lists).as_json
      end

      def create
        begin
          shopping_list = ShoppingList.new(shopping_list_params)
          shopping_list.save!
          render json: ShoppingListRepresenter.new(shopping_list).as_json, status: :created
        rescue => e
          render json: e.message, status: :unprocessable_entity
        end
      end

      private

      def shopping_list_params
        params.require(:shopping_list).permit(:name).merge(user_id: @current_user_id)
      end
    end
  end
end
