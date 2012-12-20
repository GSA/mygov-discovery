class RatingToAvgRating < ActiveRecord::Migration
  def change
    rename_column :pages, :rating, :avg_rating
    add_index :pages, :avg_rating  
  end
end
