class IndexComments < ActiveRecord::Migration
  def change
    add_index :comments, :page_id
    add_index :comments, :user_id
  end
end
