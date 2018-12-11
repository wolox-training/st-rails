class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, :book_id, :start_date, :end_date, presence: true
end