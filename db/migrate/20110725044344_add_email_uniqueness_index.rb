class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    # add_index to :users. to :email, add a unique constriction.
    add_index :users, :email, :unique => true
  end

  def self.down
    remove_index :users, :email
  end
end
