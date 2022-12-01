class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone_number
      t.boolean :is_archived, default: false

      t.timestamps
    end
    add_index :customers, :phone_number, unique: true
  end
end
