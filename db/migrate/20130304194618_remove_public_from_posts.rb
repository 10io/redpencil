class RemovePublicFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :public
  end

  def down
    add_column :posts, :public, :boolean, :default => false
  end
end
