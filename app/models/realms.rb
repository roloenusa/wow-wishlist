class Realms < ActiveRecord::Base
  
  validates :name,  :presence => true
  validates :slug,  :presence => true
  validates :region, :presence => true
  
  validates_uniqueness_of :name, :scope => :region
  
  def self.save_from_battlenet(battlenet = {})
    bn_hash = battlenet[:realms]
    
    bn_hash.each do |t|
      Realms.create(t.merge(:region => battlenet[:region]))
    end
  end
end
