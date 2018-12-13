class User < ApplicationRecord
  LOCALES = ['es', 'en']

  devise :database_authenticatable, :registerable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :rents, dependent: :nullify

  validates :first_name, :last_name, :locale, presence: true
  validates_inclusion_of :locale, in: LOCALES
end
