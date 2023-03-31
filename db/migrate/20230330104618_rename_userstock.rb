class RenameUserstock < ActiveRecord::Migration[6.1]
  def change
    rename_table :users_stocks, :user_stocks
  end
end
