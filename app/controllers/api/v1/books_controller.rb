module Api
  module V1
    class BooksController < ApiV1Controller
      def index
        render_paginated Book
      end

      def show
        render json: book
      end

      private

      def book
        Book.find(params.require(:id_2))
      end
    end
  end
end
