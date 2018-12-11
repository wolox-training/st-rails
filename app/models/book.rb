class Book < ApplicationRecord
  has_many :rents, dependent: :nullify

  validates :title, :genre, :author, :image, :editor, :year, presence: true
end
