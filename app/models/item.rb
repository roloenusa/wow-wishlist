class Item < ActiveRecord::Base
  
  validates :id,    :presence => true
  validates :name,  :presence => true
  validates :icon,  :presence => true
  
  has_many :bounds,     :dependent => :destroy
  
  def self.find_or_create(item_id) 
    
    unless item = Item.find_by_id(item_id)
      if item  = Item.new(get_from_battlenet(item_id)) 
        item.id = item_id
        item.save
      end
    end
    
    item.valid? ? item : nil
  end
  
  def self.get_from_battlenet(item_id)
    bn = Battlenet::get_item(item_id)
    
    if bn[:status].nil?
      bn[:bonusstats] = bn[:bonusstats].to_s unless bn[:bonusstats].nil?
      bn[:itemspells] = bn[:itemspells].to_s unless bn[:itemspells].nil?
      bn[:itemsource] = bn[:itemsource].to_s unless bn[:itemsource].nil?
      bn[:weaponinfo] = bn[:weaponinfo].to_s unless bn[:weaponinfo].nil?
      return bn
    end
    return nil
  end
  
  def prepare!
    self.bonusstats = eval(self.bonusstats) unless self.bonusstats.nil?
    self.itemspells = eval(self.itemspells) unless self.itemspells.nil?
    self.itemsource = eval(self.itemsource) unless self.itemsource.nil?
    self.weaponinfo = eval(self.weaponinfo) unless self.weaponinfo.nil?
    return self
  end
end  