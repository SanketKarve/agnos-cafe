class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.references :customer, null: false, foreign_key: true, null: false
      t.references :product, null: false, foreign_key: true, null: false
      t.integer :quantity, default: 0
      t.boolean :is_archived, default: false

      t.timestamps
    end
  end
end
