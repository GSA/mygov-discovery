class AddUsersBackInDangit < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "ip"
      t.boolean "blocked"
      t.timestamps
    end
  end
end
