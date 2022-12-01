class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, default: 0
      t.integer :quantity, default: 0
      t.boolean :is_archived, default: false

      t.timestamps
    end
  end
end
