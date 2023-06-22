class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false
      t.string :nickname
      t.integer :my_id
      t.timestamps
    end
  end
end
