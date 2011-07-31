class Character < ActiveRecord::Base
  validates :name,  :presence => true
  validates :realm, :presence => true
  
  def self.clean_hash(attr)
  #  c = Character.new
  #  attr = c.attributes.merge(attr)
  #  attr.delete_if {|k, v| !c.attributes.include?(k)}
  end
  
end
