class Realm < ActiveRecord::Base
  has_many :characters, :foreign_key => "realm_id"
  
  validates :name,  :presence => true
  validates :slug,  :presence => true
  validates :region, :presence => true
  
  validates_uniqueness_of :name, :scope => :region
  
  def self.save_from_battlenet(battlenet = {})
    bn_hash = battlenet[:realms]
    
    bn_hash.each do |t|
      Realm.create(t.merge(:region => battlenet[:region]))
    end
  end
  
  def self.find_by_region_and_name(region, name, quantity = :first)
    Realm.find(quantity, 
                :conditions => ["name like ? and region like ?", 
                name, region])
  end
end
