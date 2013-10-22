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

ActiveRecord::Schema.define(version: 20131022194619) do

  create_table "activities", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assets", force: true do |t|
    t.string   "asset"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_type"
  end

  create_table "comments", force: true do |t|
    t.text     "text"
    t.integer  "folder_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state_id"
    t.integer  "previous_state_id"
  end

  create_table "folder_watchers", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "folder_id"
  end

  create_table "folders", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "state_id"
  end

  add_index "folders", ["activity_id"], name: "index_folders_on_activity_id"
  add_index "folders", ["state_id"], name: "index_folders_on_state_id"
  add_index "folders", ["user_id"], name: "index_folders_on_user_id"

  create_table "folders_tags", id: false, force: true do |t|
    t.integer "tag_id"
    t.integer "folder_id"
  end

  create_table "permissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "thing_id"
    t.string   "thing_type"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id"

  create_table "states", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.string   "background"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default",    default: false
  end

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: false
  end

end
