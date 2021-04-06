module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :authenticate_user, only: [:create, :destroy]
      
      def index
        categories = Category.all

        render json: CategoriesRepresenter.new(categories).as_json
      end

      def create
        category = Category.new(category_params)

        if category.save
          render json: CategoryRepresenter.new(category).as_json, status: :created
        else
          render json: category.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Category.find(params[:id]).destroy!

        head :no_content
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
