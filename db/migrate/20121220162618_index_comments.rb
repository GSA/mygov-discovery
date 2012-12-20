class IndexComments < ActiveRecord::Migration
  def change
    add_index "comments", ["page_id"], :name => "index_comments_on_page_id"
    add_index "comments", ["user_id"], :name => "index_comments_on_user_id"
  end
end
