class AddColumnToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :weaponinfo, :string
  end

  def self.down
    remove_column :items, :weaponinfo
  end
end
