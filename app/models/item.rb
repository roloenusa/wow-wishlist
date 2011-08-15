class Item < ActiveRecord::Base
  
  validates :id,    :presence => true
  validates :name,  :presence => true
  validates :icon,  :presence => true
  
  def self.get_from_battlenet(item_id)
    bn = Battlenet::get_item(item_id)
    bn[:bonusstats] = bn[:bonusstats].to_s unless bn[:bonusstats].nil?
    bn[:itemspells] = bn[:itemspells].to_s unless bn[:itemspells].nil?
    bn[:itemsource] = bn[:itemsource].to_s unless bn[:itemsource].nil?
    bn[:weaponinfo] = bn[:weaponinfo].to_s unless bn[:weaponinfo].nil?
    return bn
  end
  
  def prepare!
    self.bonusstats = eval(self.bonusstats) unless self.bonusstats.nil?
    self.itemspells = eval(self.itemspells) unless self.itemspells.nil?
    self.itemsource = eval(self.itemsource) unless self.itemsource.nil?
    self.weaponinfo = eval(self.weaponinfo) unless self.weaponinfo.nil?
    return self
  end
end  