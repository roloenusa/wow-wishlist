class Character < ActiveRecord::Base
  belongs_to :realm
  
  has_many :relationships,  :dependent => :destroy
  has_many :owners,         :through => :relationships, :source => :user
  
  has_many :triptyches,     :dependent => :destroy
  
  validates :name,    :presence => true
  validates :realm_id,  :presence => true
  validates_uniqueness_of :name, :scope => :realm_id


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
      @character = realm.characters.create(bn) unless realm.nil?
    end
    
    (@character.nil? || @character.id.nil?) ? nil : @character
  end
end