class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stock_food, null: false, foreign_key: true
      t.integer :action
      t.boolean :is_checked, default: false, null: false

      t.timestamps
    end
  end
end
