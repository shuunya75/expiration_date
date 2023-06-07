class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.references :user, null: false
      t.string :image
      t.string :name, null: false
      t.text :content
      t.integer :management
      t.date :limit
      t.integer :count
      t.timestamps
    end
  end
end
