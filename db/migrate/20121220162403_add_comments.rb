class AddComments < ActiveRecord::Migration
  def change     
    create_table :comments do |t|
      t.integer "user_id"
      t.integer "page_id"
      t.string "body"
      t.timestamps
    end
    add_column :ratings, :created_at, :datetime
    add_column :ratings, :updated_at, :datetime
  end
end
