class AddNotNullToBookFields < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :title, :string, null: false
    change_column :books, :genre, :string, null: false
    change_column :books, :author, :string, null: false
    change_column :books, :image, :string, null: false
    change_column :books, :editor, :string, null: false
    change_column :books, :year, :string, null: false
  end
end
