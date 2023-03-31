class CreateUsersStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :users_stocks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true

      t.timestamps
    end
  end
end
