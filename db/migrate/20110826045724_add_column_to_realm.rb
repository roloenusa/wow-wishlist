class AddColumnToRealm < ActiveRecord::Migration
  def self.up
    add_column :realms, :battlegroup, :string
  end

  def self.down
    remove_column :realms, :battlegroup
  end
end
