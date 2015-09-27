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

ActiveRecord::Schema.define(version: 20150926204513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.text     "token"
    t.datetime "token_expiry_at"
    t.string   "token_secret"
    t.string   "string"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "device_registrations", force: :cascade do |t|
    t.string   "device_id"
    t.string   "email"
    t.text     "registration_key"
    t.integer  "user_id"
    t.string   "platform"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "status_id"
    t.date     "date"
    t.integer  "max_people"
    t.string   "location"
    t.float    "location_lat"
    t.float    "location_lng"
    t.integer  "user_id"
    t.integer  "post_status_id"
    t.float    "user_lat"
    t.float    "user_lng"
    t.text     "description"
    t.integer  "min_people"
    t.integer  "category_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "posts_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts_invites", force: :cascade do |t|
    t.integer  "accepted_by"
    t.integer  "post_id"
    t.integer  "invite_status_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "posts_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             default: "", null: false
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.string   "password"
    t.text     "about_me"
    t.string   "city"
    t.string   "profile_img"
    t.string   "cover_img"
    t.string   "last_search"
    t.string   "phone"
    t.integer  "profile_id"
    t.string   "profile_type"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
