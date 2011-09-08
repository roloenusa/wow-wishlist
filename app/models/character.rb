class Character < ActiveRecord::Base
  belongs_to :realm
  
  has_many :relationships,  :dependent => :destroy
  has_many :owners,         :through => :relationships, :source => :user
  
  validates :name,    :presence => true
  validates :realm_id,  :presence => true
  validates_uniqueness_of :name, :scope => :realm_id
  
  attr_accessor :inventory, :lastModified
  
  def update_from_battlenet?
    battlenet = Character.get_from_battlenet(self.realm.region, self.realm.slug, self.name)    
    unless battlenet.nil?
      return self.update_attributes(battlenet) ? true : false
    end
    return false
  end
  
  def self.find_by_realm(region, realm, name)
    if realm = Realm.find_by_region_and_name(region, realm)
      if character = realm.characters.find_by_name(name.capitalize)
        return character
      end
    end
  end
  
  def self.find_by_realm_id(realm_id, name)
    character = Realm.find_by_id(realm_id).characters.find_by_name(name.capitalize)
  end
  
  def self.get_from_battlenet(region, realm_slug, name)
    bn = Battlenet::get_character(region, realm_slug, name, 'items')
    if bn[:status].nil?
      bn.delete(:realm)
      bn.delete(:status)
      bn[:items] = bn[:items].to_s unless bn[:items].nil?
      return bn
    end
    
    return nil
  end
  
  def self.find_or_create(region, realm, name)
    
    unless @character = Character.find_by_realm(region, realm, name)
      bn = Character.get_from_battlenet(region, realm, name)
      realm = Realm.find_by_region_and_name(region, realm)
      @character = realm.characters.create(bn) if realm
    end
    
    (@character.nil? || @character.id.nil?) ? nil : @character
  end
  
  def create_inventory
    
    self.items = eval(self.items ||= "{}")
    @inventory = []
    self.items.each do |k,v|
      if v.is_a?(Hash)
        if i = Item.find_or_create(v[:id])
          i.tooltipParams = v[:tooltipParams]
          @inventory << i
        end
      end
    end
  end
  
  #Gotta update the time manually since it's comes on Java and not Unix format
  def lastModified=(time)
    @lastModified = Time.at(time/1000)
  end
end