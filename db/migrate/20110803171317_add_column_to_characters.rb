class AddColumnToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :region, :string
  end

  def self.down
    remove_column :characters, :region
  end
end
