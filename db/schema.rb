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

ActiveRecord::Schema.define(:version => 20121220162618) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "page_id"
    t.string   "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["page_id"], :name => "index_comments_on_page_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "domains", :force => true do |t|
    t.string "hostname_reversed"
    t.string "hostname_hash"
  end

  add_index "domains", ["hostname_hash"], :name => "index_domains_on_hostname_hash", :unique => true

  create_table "pages", :force => true do |t|
    t.string  "url_hash"
    t.string  "path"
    t.integer "domain_id"
    t.string  "title"
    t.decimal "avg_rating"
  end

  add_index "pages", ["avg_rating"], :name => "index_pages_on_rating"

  create_table "ratings", :force => true do |t|
    t.integer  "page_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string  "ip"
    t.boolean "blocked"
  end

end
