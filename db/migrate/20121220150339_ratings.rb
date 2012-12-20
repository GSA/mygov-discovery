class Ratings < ActiveRecord::Migration
  def change
    drop_table :ratings
    drop_table :rates
    
    create_table :ratings do |t|
      t.integer "page_id"
      t.integer "user_id"
      t.integer "value"
    end
    
  end
end
