class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: true
      t.string :mode, default: 'ONLINE'
      t.string :transaction_id
      t.decimal :amount, precision: 5, scale: 2, default: 0
      t.string :status, default: 'INITIATED'
      t.boolean :is_archived, default: false

      t.timestamps
    end
  end
end
