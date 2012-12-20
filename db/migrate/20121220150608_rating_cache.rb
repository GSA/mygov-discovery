class RatingCache < ActiveRecord::Migration
  def change
    add_column :pages, :rating, :decimal
    add_index :pages, :rating
    add_index :ratings, :page_id
    add_index :ratings, :user_id
  end
end
