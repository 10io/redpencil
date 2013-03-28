class AddUserIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, 'user_id', :integer, :null => false, :default => 0
  end
end
