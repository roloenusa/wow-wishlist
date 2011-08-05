class Character < ActiveRecord::Base
  belongs_to :realm
  
  validates :name,    :presence => true
  validates :realm,   :presence => true
  validates :realm_id,  :presence => true


  def realm_name
    realm.name if realm
  end
  
  def realm_name=(name)
    self.realm = Realm.find_by_name(name) unless name.blank?
  end
  
  def update_from_battlenet(battlenet = {})
    if battlenet[:status].nil?
      battlenet.delete(:status)
      self.update_attributes(battlenet.merge(:realm_id => Realms.find_by_name(battlenet[:realm])))
    end
  end
  
  
  def self.find_or_retrieve(region, realm, name)
    
    realm = Realm.find_by_region_and_name(region, realm)
    
    unless realm.nil? 
      unless @character = realm.characters.find_by_name(name.capitalize) 
        bn = BattleNet::getCharacter(:region => region, :realm => realm.name, :name => name)
        @character = Character.create(bn.merge(:realm_id => realm.id, :realm => realm)) if bn[:status] != 'nok'
      end
    end
    
    return @character
  end
  
end
