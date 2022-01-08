class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      t.integer :recipe_id
      t.integer :step, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
