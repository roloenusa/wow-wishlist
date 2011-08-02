class RenameDatabaseColumn < ActiveRecord::Migration
  def self.up
    rename_column :realms, :type, :tipe
  end

  def self.down
    rename_column :realms, :tipe, :type
  end
end
