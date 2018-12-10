class RemoveUnusedColumnsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :sign_in_count, :integer, default: 0, null: false
  end
end
