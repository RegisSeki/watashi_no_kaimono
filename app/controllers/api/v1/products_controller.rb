module Api
  module V1
    class ProductsController < ApplicationController
      include ActionController::HttpAuthentication::Token

      MAX_PAGINATION_LIMIMT = 100

      before_action :authenticate_user, only: [:create, :destroy] 

      def index
        products = Product.limit(limit).offset(params[:offset])

        render json: ProductsRepresenter.new(products).as_json
      end

      def create
      	product = Product.new(product_params)

      	if product.save
      		render json: ProductRepresenter.new(product).as_json, status: :created
      	else
      		render json: product.errors, status: :unprocessable_entity
      	end
      end

      def destroy
      	Product.find(params[:id]).destroy!

      	head :no_content  	
      end

      private

      def authenticate_user
        # binding.pry
        token, _options = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        User.find(user_id)
      rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
      end

      def limit
        [
          params.fetch(:limit, MAX_PAGINATION_LIMIMT).to_i,
          MAX_PAGINATION_LIMIMT
        ].min
      end

      def product_params
      	params.require(:product).permit(:name, :category_id)
      end
    end
  end
end
