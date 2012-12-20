class FixMissingTables < ActiveRecord::Migration
  def up
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
    end
    add_index "pages", ["url_hash"], :name => "index_pages_on_url_hash", :unique => true

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
    add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_taggable_type_context"

    create_table "tags", :force => true do |t|
      t.string "name"
    end

    create_table "users", :force => true do |t|
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end  
  end

  def down
    drop_table "domains"
    drop_table "pages"
    drop_table "taggins"
    drop_table "tags"
    drop_table "users"
  end
end