module Api
  module V1
    class ProductsController < ApplicationController  
      def index
        render json: Product.all
      end

      def create
      	product = Product.new(product_params)

      	if product.save
      		render json: product, status: :created
      	else
      		render json: product.errors, status: :unprocessable_entity
      	end
      end

      def destroy
      	Product.find(params[:id]).destroy!

      	head :no_content  	
      end

      private

      def product_params
      	params.require(:product).permit(:name, :category)
      end
    end
  end
end
