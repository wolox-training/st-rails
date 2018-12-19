class BookSuggestionSerializer < ActiveModel::Serializer
  attributes :author, :title, :link, :editor, :year, :price, :synopsis, :created_at, :updated_at
  belongs_to :user
end
