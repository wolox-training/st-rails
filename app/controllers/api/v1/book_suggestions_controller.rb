module Api
  module V1
    class BookSuggestionsController < ApiV1Controller
      skip_before_action :authenticate_api_v1_users_user!

      def create
        book_suggestion = BookSuggestion.new(book_suggestion_params)
        book_suggestion.user_id = current_api_v1_users_user.id if current_api_v1_users_user
        book_suggestion.save!
        render json: book_suggestion, status: :created
      end

      private

      def book_suggestion_params
        params.require(:book_suggestion).require(%I[author title link editor year])
        params.require(:book_suggestion).permit(:author, :title, :link, :editor, :year,
                                                :price, :synopsis)
      end
    end
  end
end
