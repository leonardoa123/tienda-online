class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
