module Api
  module V1
    class SubcategoriesController < ApplicationController
      before_action :authenticate_user, only: [:create, :update, :destroy]

      def index
        subcategories = Subcategory.all

        render json: SubcategoriesRepresenter.new(subcategories).as_json
      end

      def create
        subcategory = Subcategory.new(subcategory_params)

        if subcategory.save
          render json: SubcategoryRepresenter.new(subcategory).as_json, status: :created
        else
          render json: subcategory.errors, status: :unprocessable_entity
        end
      end

      def update
        subcategory = Subcategory.find(params[:id])

        if subcategory.update(subcategory_params)
          render json: SubcategoryRepresenter.new(subcategory).as_json, status: :ok
        else
          render json: subcategory.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Subcategory.find(params[:id]).destroy!

        head :no_content
      end

      private

      def subcategory_params
        params.require(:subcategory).permit(:name, :description, :category_id)
      end
    end
  end
end
