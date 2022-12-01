class CreateTaxes < ActiveRecord::Migration[7.0]
  def change
    create_table :taxes do |t|
      t.string :name, null: false
      t.decimal :percent, precision: 5, scale: 2, default: 0
      t.datetime :start_date, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :end_date, default: -> { 'CURRENT_TIMESTAMP' }
      t.boolean :is_archived, default: false

      t.timestamps
    end
  end
end
