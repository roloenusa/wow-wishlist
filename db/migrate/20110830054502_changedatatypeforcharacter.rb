class Changedatatypeforcharacter < ActiveRecord::Migration
  def self.up
    change_table :characters do |t|
      t.change :items, :text
    end
  end

  def self.down
    change_table :characters do |t|
      t.change :items, :string
    end
  end
end
