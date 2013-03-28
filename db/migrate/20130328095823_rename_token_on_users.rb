class RenameTokenOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :token, :token_hash
  end
end
