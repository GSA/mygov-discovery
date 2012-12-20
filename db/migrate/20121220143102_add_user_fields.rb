class AddUserFields < ActiveRecord::Migration
  def change
    drop_table :users
    
    create_table :users do |t|
      t.string "ip"
      t.boolean "blocked"
    end
  end
end
