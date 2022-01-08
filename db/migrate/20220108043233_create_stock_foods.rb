class CreateStockFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :stock_foods do |t|
      t.integer :user_id
      t.string :name, null: false
      t.date :expiration_date

      t.timestamps
    end
  end
end
