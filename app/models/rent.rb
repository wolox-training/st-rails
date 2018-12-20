class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, :book_id, :start_date, :end_date, presence: true
  validate :book_availability

  scope :rented_by, ->(user_id) { where(user_id: user_id) }
  scope :ending_today, -> { where(end_date: Time.zone.today) }

  private

  def book_availability
    return if book_id.blank? || start_date.blank? || end_date.blank?

    errors.add(:book_id, 'is not available in that timeband') if overlaping_rent_exists?
  end

  def overlaping_rent_exists?
    overlaping_rent = book.rents.where('start_date <= :end_date AND end_date >= :start_date',
                                       end_date: end_date, start_date: start_date)
    overlaping_rent = overlaping_rent.where.not(id: id) if id.present?
    overlaping_rent.exists?
  end
end
