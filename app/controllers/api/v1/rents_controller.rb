module Api
  module V1
    class RentsController < ApiV1Controller
      def index
        render_paginated Rent.rented_by(user_id).includes(:user, :book)
      end

      def create
        rent = Rent.create!(rent_params)
        render json: rent, status: :created
      end

      private

      def rent_params
        params.require(:rent).require(%I[user_id book_id start_date end_date])
        params.require(:rent).permit(:user_id, :book_id, :start_date, :end_date)
      end

      def user_id
        params.require(:user_id)
      end
    end
  end
end
