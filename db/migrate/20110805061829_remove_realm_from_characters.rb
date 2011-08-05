class RemoveRealmFromCharacters < ActiveRecord::Migration
  def self.up
    remove_column :characters, :realm
  end

  def self.down
    add_column :characters, :realm, :string
  end
end
