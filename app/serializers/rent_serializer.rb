class RentSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date

  belongs_to :book
  belongs_to :user
end
