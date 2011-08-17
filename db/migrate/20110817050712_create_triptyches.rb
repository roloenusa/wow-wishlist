class CreateTriptyches < ActiveRecord::Migration
  def self.up
    create_table :triptyches do |t|
      t.integer :user_id
      t.integer :character_id
      t.integer :item_id

      t.timestamps
    end
    
    add_index :triptyches, :user_id
    add_index :triptyches, :character_id
    add_index :triptyches, [:user_id, :character_id]
    add_index :triptyches, [:user_id, :character_id, :item_id], :unique => true
  end

  def self.down
    drop_table :triptyches
  end
end
