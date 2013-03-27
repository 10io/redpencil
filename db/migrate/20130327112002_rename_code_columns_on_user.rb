class RenameCodeColumnsOnUser < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.rename :hashed_code, :token
      t.rename :activated, :token_consumed
      t.rename :activated_at, :token_created_at
    end
  end

  def down
    change_table :users do |t|
      t.rename :token, :hashed_code
      t.rename :token_consumed, :activated
      t.rename :token_created_at, :activated_at
    end
  end
end
