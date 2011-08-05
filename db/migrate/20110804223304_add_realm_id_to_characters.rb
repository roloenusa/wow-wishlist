class AddRealmIdToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :realm_id, :integer
  end

  def self.down
    remove_column :characters, :realm_id
  end
end
