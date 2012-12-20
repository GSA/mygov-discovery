class RatingCache < ActiveRecord::Migration
  def change
    drop_table :pages
    
    create_table :pages do |t|
      t.string  "url_hash"
      t.string  "path"
      t.integer "domain_id"
      t.string  "title"
      t.decimal "rating"
    end
    
    add_index "pages", ["rating"], :name => "index_pages_on_rating"
    add_index "ratings", ["page_id"], :name => "index_ratings_on_page_id"
    add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  end
end
