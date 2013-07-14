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

ActiveRecord::Schema.define(version: 20130403135651) do

  create_table "blogs", force: true do |t|
    t.integer  "user_id",                 null: false
    t.string   "title",      default: ""
    t.string   "url",        default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "printable_name"
    t.string   "iso"
    t.string   "iso3"
    t.string   "numcode"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "users_count",    default: 0
  end

  create_table "o_auth_credentials", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.text     "params"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "o_auth_credentials", ["user_id"], name: "index_o_auth_credentials_on_user_id"

  create_table "socials", force: true do |t|
    t.integer  "user_id",                 null: false
    t.string   "title",      default: ""
    t.string   "url",        default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "bio"
    t.integer  "country_id"
    t.string   "address"
    t.integer  "looking_for_work",       default: 0
    t.boolean  "search_visibility",      default: true
    t.integer  "email_privacy",          default: 1
    t.boolean  "im_privacy",             default: false
    t.integer  "zoom"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "gtalk"
    t.string   "skype"
    t.string   "jabber"
    t.string   "github"
    t.string   "twitter"
    t.boolean  "change_password_needed", default: false
    t.string   "facebook"
  end

  add_index "users", ["country_id"], name: "index_users_on_country_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
