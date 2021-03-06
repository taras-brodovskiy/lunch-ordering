# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_13_233112) do

  create_table "contents", force: :cascade do |t|
    t.integer "order_id"
    t.integer "first_course_id"
    t.integer "main_course_id"
    t.integer "drink_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_contents_on_order_id"
  end

  create_table "fillings", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_fillings_on_item_id"
    t.index ["menu_id", "item_id"], name: "index_fillings_on_menu_id_and_item_id", unique: true
    t.index ["menu_id"], name: "index_fillings_on_menu_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 8, scale: 2
    t.string "kind"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind"], name: "index_items_on_kind"
    t.index ["name"], name: "index_items_on_name", unique: true
  end

  create_table "menus", force: :cascade do |t|
    t.date "menu_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_date"], name: "index_menus_on_menu_date", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "price", precision: 8, scale: 2
    t.date "order_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_orders_on_created_at"
    t.index ["order_date", "user_id"], name: "index_orders_on_order_date_and_user_id", unique: true
    t.index ["order_date"], name: "index_orders_on_order_date"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "remember_digest"
    t.boolean "supplier", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
