# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_05_144143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
  end

  create_table "list_items", force: :cascade do |t|
    t.bigint "shopping_list_id", null: false
    t.bigint "product_id", null: false
    t.float "required_quantity", default: 1.0, null: false
    t.float "purchased_quantity"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_list_items_on_product_id"
    t.index ["shopping_list_id", "product_id"], name: "index_list_items_on_shopping_list_id_and_product_id"
    t.index ["shopping_list_id"], name: "index_list_items_on_shopping_list_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "subcategory_id"
    t.string "code"
    t.string "img_url"
    t.index ["code"], name: "index_products_on_code", unique: true
    t.index ["name"], name: "index_products_on_name", unique: true
    t.index ["subcategory_id"], name: "index_products_on_subcategory_id"
  end

  create_table "shopping_lists", force: :cascade do |t|
    t.string "name", null: false
    t.string "status", default: "opened", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "name"], name: "index_shopping_lists_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_shopping_lists_on_user_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.datetime "token_date"
    t.string "email"
    t.boolean "valid_email"
  end

  add_foreign_key "list_items", "products"
  add_foreign_key "list_items", "shopping_lists"
  add_foreign_key "products", "subcategories"
  add_foreign_key "shopping_lists", "users"
  add_foreign_key "subcategories", "categories"
end
