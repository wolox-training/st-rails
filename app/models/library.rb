class Library < ApplicationRecord
  has_many :books, dependent: :nullify

  validates :name, :lat, :lng, presence: true
end
