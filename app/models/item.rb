class Item < ActiveRecord::Base
  
  validates :id,    :presence => true
  validates :name,  :presence => true
  validates :icon,  :presence => true
  
  def self.get_from_battlenet(item_id)
    bn = Battlenet::get_item(item_id)
    bn[:bonusstats] = bn[:bonusstats].to_s
    bn[:itemspells] = bn[:itemspells].to_s
    bn[:itemsource] = bn[:itemsource].to_s
    
    return bn
  end
end
