module Api
  module V1
    class RentsController < ApiV1Controller
      def index
        render_paginated policy_scope(Rent).includes(:user, :book)
      end

      def create
        rent = Rent.new(rent_params)
        authorize rent
        rent.save!
        RentMailer.with(rent_id: rent.id).new_rent_email.deliver_later
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
