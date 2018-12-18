module Api
  module V1
    class BooksController < ApiV1Controller
      def index
        render_paginated Book
      end

      def show
        render json: book
      end

      def info
        book_info = OpenLibraryService.new.book_info(isbn_param)
        render json: book_info, status: book_info.present? ? :ok : :not_found
      end

      private

      def book
        Book.find(params.require(:id))
      end

      def isbn_param
        params.require(:isbn)
      end
    end
  end
end
