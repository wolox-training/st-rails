module Api
  module V1
    class BooksController < ApiV1Controller
      def index
        render_paginated Book
      end

      def show
        render json: Book.find(params[:id])
      end
    end
  end
end
