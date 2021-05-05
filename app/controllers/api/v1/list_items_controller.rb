module Api
  module V1
    class ListItemsController < ApplicationController
      before_action :authenticate_user, only: [:index, :create]

      def index
        list_items = ListItem.load_items(params[:shopping_list_id])

        render json: ListItemsRepresenter.new(list_items).as_json
      end

      def create
        begin
          list_item = ListItem.find_item(list_item_parameter[:shopping_list_id], list_item_parameter[:product_id])

          if list_item.empty?
            list_item = ListItem.new(list_item_parameter)
            list_item.save!
          else
            list_item.update(list_item_parameter)
          end

          render json: ListItemRepresenter.new(list_item).as_json, status: :created
        rescue => e
          render json: e.message, status: :unprocessable_entity
        end
      end

      private

      def list_item_parameter
        params.require(:list_item).permit(
          :shopping_list_id,
          :product_id,
          :required_quantity,
          :purchased_quantity,
          :price
        )
      end
    end
  end
end
