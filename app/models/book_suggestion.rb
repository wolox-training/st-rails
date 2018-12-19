class BookSuggestion < ApplicationRecord
  belongs_to :user, optional: true

  validates :author, :title, :link, :editor, :year, presence: true
  validates :price, numericality: { greater_than: 0 }, allow_blank: true
end
