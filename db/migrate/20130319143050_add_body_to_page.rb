class AddBodyToPage < ActiveRecord::Migration
  def change
    add_column :pages, :body, :text
  end
end
