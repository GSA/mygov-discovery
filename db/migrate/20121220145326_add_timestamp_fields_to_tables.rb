class AddTimestampFieldsToTables < ActiveRecord::Migration
  def up
    add_column :domains, :created_at, :datetime
    add_column :domains, :updated_at, :datetime
    add_column :pages, :created_at, :datetime
    add_column :pages, :updated_at, :datetime
    add_column :taggings, :updated_at, :datetime
    add_column :tags, :created_at, :datetime
    add_column :tags, :updated_at, :datetime
    Domain.all.each{|domain| domain.update_attributes(:created_at => Time.now, :updated_at => Time.now)}
    Page.all.each{|page| page.update_attributes(:created_at => Time.now, :updated_at => Time.now)}
    Tag.all.each{|tag| tag.update_attributes(:created_at => Time.now, :updated_at => Time.now)}
    drop_table :users
  end
  
  def down
    create_table :users, :force => true do |t|
      t.timestamps
    end
    remove_column :tags, :updated_at
    remove_column :tags, :created_at
    remove_column :taggings, :updated_at
    remove_column :pages, :updated_at
    remove_column :pages, :created_at
    remove_column :domains, :updated_at
    remove_column :domains, :created_at
  end
end
