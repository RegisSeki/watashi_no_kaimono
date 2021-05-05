module Api
  module V1
    class ProductsController < ApplicationController
      MAX_PAGINATION_LIMIMT = 100

      before_action :authenticate_user, only: [:create, :update, :destroy]

      def index
        products = Product.limit(limit).offset(params[:offset])

        render json: ProductsRepresenter.new(products).as_json
      end

      def create
        begin
        	product = Product.new(product_params)
        	product.save!
          render json: ProductRepresenter.new(product).as_json, status: :created
      	rescue => e
      		render json: e.message, status: :unprocessable_entity
      	end
      end

      def update
        product = Product.find(params[:id])

        if product.update(product_params)
          render json: ProductRepresenter.new(product).as_json, status: :ok
        else
          render json: product.errors, status: :unprocessable_entity
        end
      end

      def destroy
      	Product.find(params[:id]).destroy!

      	head :no_content
      end

      def search
        products = Product.limit(limit).offset(params[:offset])

        render json: ProductsRepresenter.new(products).as_json
      end

      private

      def limit
        [
          params.fetch(:limit, MAX_PAGINATION_LIMIMT).to_i,
          MAX_PAGINATION_LIMIMT
        ].min
      end

      def product_params
      	params.require(:product).permit(:name, :code, :img_url, :subcategory_id)
      end
    end
  end
end
