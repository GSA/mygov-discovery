class RatingToAvgRating < ActiveRecord::Migration
  def change
    drop_table :pages
    
    create_table :pages do |t|
      t.string  "url_hash"
      t.string  "path"
      t.integer "domain_id"
      t.string  "title"
      t.decimal "avg_rating"
    end
    
    add_index "pages", ["avg_rating"], :name => "index_pages_on_rating"
    
  end
end
