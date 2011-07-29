class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.integer :lastModified
      t.string :name
      t.string :realm
      t.integer :class
      t.integer :race
      t.integer :gender
      t.integer :level
      t.integer :achievementPoints
      t.string :thumbnail

      t.timestamps
    end
  end

  def self.down
    drop_table :characters
  end
end
