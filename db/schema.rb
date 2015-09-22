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

ActiveRecord::Schema.define(version: 20150922054707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "chefs", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.string   "phone"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "chefs", ["restaurant_id"], name: "index_chefs_on_restaurant_id", using: :btree

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
    t.integer  "user_id"
    t.integer  "member_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "ingredients", ["member_id"], name: "index_ingredients_on_member_id", using: :btree
  add_index "ingredients", ["user_id"], name: "index_ingredients_on_user_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.float    "dob"
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

  create_table "product_ingredients", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "ingredient_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "product_ingredients", ["ingredient_id"], name: "index_product_ingredients_on_ingredient_id", using: :btree
  add_index "product_ingredients", ["product_id"], name: "index_product_ingredients_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "restaurant_id"
    t.integer  "chef_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "products", ["chef_id"], name: "index_products_on_chef_id", using: :btree
  add_index "products", ["restaurant_id"], name: "index_products_on_restaurant_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "restaurant_name"
    t.string   "email"
    t.string   "image"
    t.string   "phone"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "scan_histories", force: :cascade do |t|
    t.string   "product_name"
    t.string   "result"
    t.string   "image"
    t.string   "history_type"
    t.string   "unsafe_users", default: [],              array: true
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "scan_histories", ["user_id"], name: "index_scan_histories_on_user_id", using: :btree

  create_table "social_authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider_name"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "social_authentications", ["user_id"], name: "index_social_authentications_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.string   "password_digest"
    t.string   "user_type"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.datetime "confirmed_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_token_sent_at"
    t.datetime "password_confirmed_at"
    t.string   "signup_type"
    t.boolean  "status"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.float    "dob"
  end

  add_foreign_key "chefs", "restaurants"
  add_foreign_key "devices", "users"
  add_foreign_key "ingredients", "members"
  add_foreign_key "ingredients", "users"
  add_foreign_key "members", "users"
  add_foreign_key "preventives", "members"
  add_foreign_key "preventives", "users"
  add_foreign_key "product_ingredients", "ingredients"
  add_foreign_key "product_ingredients", "products"
  add_foreign_key "products", "chefs"
  add_foreign_key "products", "restaurants"
  add_foreign_key "scan_histories", "users"
  add_foreign_key "social_authentications", "users"
end
