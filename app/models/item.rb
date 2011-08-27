class Item < ActiveRecord::Base
  
  validates :id,    :presence => true
  validates :name,  :presence => true
  validates :icon,  :presence => true
  
  has_many :bounds,     :dependent => :destroy
  
  attr_accessor :tooltipParams
  
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
      bn[:bonusStats] = bn[:bonusStats].to_s unless bn[:bonusStats].nil?
      bn[:itemSpells] = bn[:itemSpells].to_s unless bn[:itemSpells].nil?
      bn[:itemSource] = bn[:itemSource].to_s unless bn[:itemSource].nil?
      bn[:weaponInfo] = bn[:weaponInfo].to_s unless bn[:weaponInfo].nil?
      return bn
    end
    return nil
  end
  
  def prepare!
    self.bonusStats = eval(self.bonusStats) unless self.bonusStats.nil?
    self.itemSpells = eval(self.itemSpells) unless self.itemSpells.nil?
    self.itemSource = eval(self.itemSource) unless self.itemSource.nil?
    self.weaponInfo = eval(self.weaponInfo) unless self.weaponInfo.nil?
    return self
  end
end  