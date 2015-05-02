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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150502001742) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "breeders", :force => true do |t|
    t.string  "name"
    t.string  "location"
    t.string  "website"
    t.string  "kennel"
    t.string  "city"
    t.string  "state"
    t.float   "latitude"
    t.float   "longitude"
    t.integer "removed_reviews", :default => 0
  end

  create_table "pups", :force => true do |t|
    t.string   "pup_name"
    t.string   "owner_name"
    t.string   "breed_1"
    t.string   "breed_2"
    t.integer  "breeder_responsibility"
    t.integer  "overall_health"
    t.integer  "trainability"
    t.integer  "social_behavior"
    t.integer  "energy_level"
    t.integer  "simpatico_rating"
    t.text     "comments"
    t.integer  "breeder_id"
    t.string   "hashtag_1"
    t.string   "hashtag_2"
    t.string   "hashtag_3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "text", :force => true do |t|
    t.string  "section_title", :default => ""
    t.integer "section_order", :default => 0
    t.string  "title",         :default => ""
    t.text    "text",          :default => ""
  end

  create_table "texts", :force => true do |t|
    t.string  "section_title", :default => ""
    t.integer "section_order", :default => 0
    t.string  "title",         :default => ""
    t.text    "text",          :default => ""
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
