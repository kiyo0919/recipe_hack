class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.integer :genre_id
      t.string :title
      t.text :catch_phrase
      t.string :number_of_persons
      t.text :tip
      t.text :background

      t.timestamps
    end
  end
end
