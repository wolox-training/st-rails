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
    condition_params = { end_date: end_date, start_date: start_date }
    overlaping_rent = Rent.where(book_id: book_id).where(book_availability_conditions,
                                                         condition_params)
    overlaping_rent = overlaping_rent.where.not(id: id) if id.present?
    overlaping_rent.exists?
  end

  def book_availability_conditions
    'start_date <= :start_date AND end_date >= :start_date
     OR start_date <= :end_date AND end_date >= :end_date
     OR start_date >= :start_date AND start_date <= :end_date
     OR end_date >= :start_date AND end_date <= :end_date'
  end
end
