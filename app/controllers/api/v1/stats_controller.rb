module Api
  module V1
    class StatsController < ApplicationController
      before_action :authenticate_user, only: [:index]
      
      def index
        stats = {
          categories: Category.count,
          products: Product.count,
          users: User.count
        }

        render json: stats, status: :ok
      end
    end
  end
end
