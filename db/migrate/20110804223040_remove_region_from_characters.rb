class RemoveRegionFromCharacters < ActiveRecord::Migration
  def self.up
    remove_column :characters, :region
  end

  def self.down
    add_column :characters, :region, :string
  end
end
