class BookSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :image, :editor, :year, :genre, :created_at, :updated_at

  def image
    { url: object.image }
  end
end
