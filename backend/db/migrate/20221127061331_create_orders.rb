class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.decimal :total_price, precision: 5, scale: 2, default: 0
      t.decimal :tax_price, precision: 5, scale: 2, default: 0
      t.decimal :net_price, precision: 5, scale: 2, default: 0
      t.boolean :is_archived, default: false

      t.timestamps
    end
  end
end
