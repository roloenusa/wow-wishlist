class AddColumnGemInfotoitems < ActiveRecord::Migration
  def self.up
    add_column :items, :gemInfo, :string
  end

  def self.down
    remove_column :items, :gemInfo
  end
end
