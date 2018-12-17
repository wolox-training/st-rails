class User < ApplicationRecord
  LOCALES = %w[es en].freeze

  devise :database_authenticatable, :registerable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :rents, dependent: :nullify

  validates :first_name, :last_name, :locale, presence: true
  validates :locale, inclusion: LOCALES
end
