class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.integer :cLastModified
      t.string :cName
      t.string :cRealm
      t.integer :cClass
      t.integer :cRace
      t.integer :cGender
      t.integer :cLevel
      t.integer :cAchievementPoints
      t.string :cThumbnail

      t.timestamps
    end
    add_index :characters, [:cName, :cRealm], :unique => true
  end

  def self.down
    drop_table :characters
  end
end
