class AddDeviseTokenAuthToUsers < ActiveRecord::Migration[5.2]
    
  def up
     add_column :users, :provider, :string, null: false, default: 'email'
     add_column :users, :uid, :string, null: false, default: ''
     add_column :users, :tokens, :text

     add_column :users, :sign_in_count, :integer, default: 0, null: false
     add_column :users, :current_sign_in_at, :datetime
     add_column :users, :last_sign_in_at, :datetime
     add_column :users, :current_sign_in_ip, :inet
     add_column :users, :last_sign_in_ip, :inet

     User.reset_column_information

     # finds all existing users and updates them.
     # if you change the default values above you'll also have to change them here below:
     User.find_each do |user|
       user.uid = user.email
       user.provider = 'email'
       user.save!
     end

     # to speed up lookups to these columns:
     add_index :users, [:uid, :provider], unique: true
   end

   def down
     remove_columns :users, :provider, :uid, :tokens, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
   end
end
