# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_27_195335) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.boolean "is_archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number"], name: "index_customers_on_phone_number", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.decimal "total_price", precision: 5, scale: 2, default: "0.0"
    t.decimal "tax_price", precision: 5, scale: 2, default: "0.0"
    t.decimal "net_price", precision: 5, scale: 2, default: "0.0"
    t.boolean "is_archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "mode", default: "ONLINE"
    t.string "transaction_id"
    t.decimal "amount", precision: 5, scale: 2, default: "0.0"
    t.string "status", default: "INITIATED"
    t.boolean "is_archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.decimal "price", precision: 10, scale: 2, default: "0.0"
    t.integer "quantity", default: 0
    t.boolean "is_archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity", default: 0
    t.boolean "is_archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id", null: false
    t.index ["customer_id"], name: "index_purchases_on_customer_id"
    t.index ["order_id"], name: "index_purchases_on_order_id"
    t.index ["product_id"], name: "index_purchases_on_product_id"
  end

  create_table "tax_groups", force: :cascade do |t|
    t.string "products", default: [], array: true
    t.bigint "tax_id", null: false
    t.boolean "is_archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tax_id"], name: "index_tax_groups_on_tax_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "percent", precision: 5, scale: 2, default: "0.0"
    t.datetime "start_date", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "end_date", default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "is_archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "orders", "customers"
  add_foreign_key "payments", "orders"
  add_foreign_key "purchases", "customers"
  add_foreign_key "purchases", "orders"
  add_foreign_key "purchases", "products"
  add_foreign_key "tax_groups", "taxes"
end
