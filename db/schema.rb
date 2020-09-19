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

ActiveRecord::Schema.define(version: 2020_09_19_204319) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "item_groups", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "name"
    t.integer "budget"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_item_groups_on_project_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "item_group_id", null: false
    t.string "name"
    t.integer "quantity"
    t.integer "purchase_price_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_group_id"], name: "index_items_on_item_group_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.integer "budget"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "item_groups", "projects"
  add_foreign_key "items", "item_groups"
end
