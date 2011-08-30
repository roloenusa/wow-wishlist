class ReplaceColumnInCharacter < ActiveRecord::Migration
  def self.up
    remove_column :characters, :lastModified
    add_column :characters, :lastModified, :timestamp
  end

  def self.down
    remove_column :characters, :lastModified
    add_column :characters, :lastModified, :integer
  end
end
