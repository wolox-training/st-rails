class AddNotNullConstraintToBookSuggestionTimestamps < ActiveRecord::Migration[5.2]
  def up
    BookSuggestion.where(created_at: nil).update_all(created_at: 2.weeks.ago)
    BookSuggestion.where(updated_at: nil).update_all(updated_at: 2.weeks.ago)
    change_column :book_suggestions, :created_at, :datetime, null: false
    change_column :book_suggestions, :updated_at, :datetime, null: false
  end

  def down
    change_column :book_suggestions, :created_at, :datetime, null: true
    change_column :book_suggestions, :updated_at, :datetime, null: true
  end

end
