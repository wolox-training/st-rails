class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :rents, dependent: :nullify

  validates :first_name, :last_name, presence: true
end
