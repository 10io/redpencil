class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.boolean :public, :default => false

      t.timestamps
    end
  end
end
