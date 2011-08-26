class AddColumnToItems20110825 < ActiveRecord::Migration
  def self.up
    add_column :items, :allowableclasses, :string
    add_column :items, :itemset, :string
  end

  def self.down
    remove_column :items, :allowableclasses
    remove_column :items, :itemset
  end
end
