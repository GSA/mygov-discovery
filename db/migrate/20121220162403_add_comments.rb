class AddComments < ActiveRecord::Migration
  def change   
  
    create_table :comments do |t|
      t.integer "user_id"
      t.integer "page_id"
      t.string "body"
      t.timestamps
    end
    drop_table :ratings
    
    create_table :ratings do |t|
      t.integer "page_id"
      t.integer "user_id"
      t.integer "value"
      t.timestamps
    end

  end
end
