class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :hashed_code
      t.boolean :activated, :default => false
      t.timestamp :activated_at

      t.timestamps
    end
  end
end
