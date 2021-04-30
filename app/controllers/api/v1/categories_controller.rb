module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :authenticate_user, only: [:create, :update, :destroy]

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

      def update
        category = Category.find(params[:id])

        if category.update(category_params)

          render json: CategoryRepresenter.new(category).as_json, status: :ok
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
        params.require(:category).permit(:name, :description)
      end
    end
  end
end
