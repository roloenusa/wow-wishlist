class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :disenchantingskillrank
      t.string  :description
      t.string  :name
      t.string  :icon
      t.integer :stackable	
      t.integer :itembind	
      t.string  :bonusstats	
      t.string  :itemspells	
      t.integer :buyprice	
      t.integer :itemclass	
      t.integer :itemsubclass	
      t.integer :containerslots	
      t.integer :inventorytype	
      t.boolean :equippable	
      t.integer :itemlevel	
      t.integer :maxcount	
      t.integer :maxdurability	
      t.integer :minfactionid	
      t.integer :minreputation	
      t.integer :quality	
      t.integer :sellprice	
      t.integer :requiredlevel	
      t.integer :requiredskill	
      t.integer :requiredskillrank	
      t.string  :socketinfo	
      t.string  :itemsource	
      t.integer :basearmor	
      t.boolean :hassockets	
      t.boolean :isauctionable

      t.timestamps
    end
    
    add_index :items, :id
    add_index :items, :name
  end

  def self.down
    drop_table :items
  end
end
