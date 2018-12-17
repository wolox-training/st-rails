class BookSuggestionSerializer < ActiveModel::Serializer
  attributes :author, :title, :link, :editor, :year, :price, :synopsis, :created_at, :updated_at
end
