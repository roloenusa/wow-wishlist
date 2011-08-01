class CreateRealms < ActiveRecord::Migration
  def self.up
    create_table :realms do |t|
      t.string :region
      t.string :type
      t.boolean :queue
      t.boolean :status
      t.string :population
      t.string :name
      t.string :slug

      t.timestamps
    end
    
    add_index :realms, [:region, :name], :unique => true
  end

  def self.down
    drop_table :realms
  end
end
