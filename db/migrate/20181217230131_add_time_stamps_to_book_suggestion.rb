class AddTimeStampsToBookSuggestion < ActiveRecord::Migration[5.2]
  def change
    add_column :book_suggestions, :created_at, :datetime
    add_column :book_suggestions, :updated_at, :datetime
  end
end
