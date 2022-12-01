class CreateTaxGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :tax_groups do |t|
      t.string :products, array: true, default: []
      t.references :tax, null: false, foreign_key: true
      t.boolean :is_archived, default: false

      t.timestamps
    end
  end
end
