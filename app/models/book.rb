class Book < ApplicationRecord
  validates :title, :genre, :author, :image, :editor, :year, presence: true
end
