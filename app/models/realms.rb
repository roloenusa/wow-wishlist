class Realms < ActiveRecord::Base

  attr_accessible :region, :name, :slug
  
  validates :name,  :presence => true
  validates :slug,  :presence => true
  validates :region, :presence => true
  
  validates_uniqueness_of :name, :scope => :region
end
