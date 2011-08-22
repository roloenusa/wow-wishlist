class CreateBounds < ActiveRecord::Migration
  def self.up
    create_table :bounds do |t|
      t.integer :item_id
      t.references :persona, :polymorphic => true

      t.timestamps
    end
    
    add_index :bounds, :persona_id
    add_index :bounds, :item_id
    add_index :bounds, [:persona_id, :persona_type, :item_id], :unique => true
  end

  def self.down
    drop_table :bounds
  end
end
