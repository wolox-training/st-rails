class Book < ApplicationRecord
  has_many :rents, dependent: :nullify
  belongs_to :library, optional: true

  validates :title, :genre, :author, :image, :editor, :year, presence: true
end
