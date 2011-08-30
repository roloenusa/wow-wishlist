class ReplaceColumnInCharactersItems < ActiveRecord::Migration
  def self.up
    remove_column :characters, :items
    add_column :characters, :items, :text
  end

  def self.down
    remove_column :characters, :items
    add_column :characters, :items, :string
  end
end
