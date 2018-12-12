module Api
  module V1
    class RentsController < ApiV1Controller
      def index
        render_paginated Rent.rented_by(user_id)
      end

      def create
        rent = Rent.new(rent_params)
        if rent.save
          render json: rent, status: :created
        else
          render json: { errors: rent.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def rent_params
        params.require(:rent).permit(:user_id, :book_id, :start_date, :end_date)
      end

      def user_id
        params.require(:user_id)
      end
    end
  end
end
