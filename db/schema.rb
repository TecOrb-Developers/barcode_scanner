# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150829093654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "subject"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "infos", force: :cascade do |t|
    t.string   "page_name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string   "ingredient_name"
    t.string   "product_name"
    t.string   "image_urls"
    t.integer  "user_id"
    t.integer  "member_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "ingredients", ["member_id"], name: "index_ingredients_on_member_id", using: :btree
  add_index "ingredients", ["user_id"], name: "index_ingredients_on_user_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.date     "dob"
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "preventives", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "preventives", ["member_id"], name: "index_preventives_on_member_id", using: :btree
  add_index "preventives", ["user_id"], name: "index_preventives_on_user_id", using: :btree

  create_table "social_authentications", force: :cascade do |t|
    t.string   "provider_name"
    t.integer  "uid"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "social_authentications", ["user_id"], name: "index_social_authentications_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.date     "DOB"
    t.string   "password_digest"
    t.string   "user_type"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.datetime "confirmed_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_token_sent_at"
    t.datetime "password_confirmed_at"
    t.boolean  "status"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "image"
  end

  add_foreign_key "devices", "users"
  add_foreign_key "ingredients", "members"
  add_foreign_key "ingredients", "users"
  add_foreign_key "members", "users"
  add_foreign_key "preventives", "members"
  add_foreign_key "preventives", "users"
  add_foreign_key "social_authentications", "users"
end
