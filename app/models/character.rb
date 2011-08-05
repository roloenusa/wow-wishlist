class Character < ActiveRecord::Base
  belongs_to :realm
  
  validates :name,    :presence => true
  validates :realm_id,  :presence => true


  def update_from_battlenet
    battlenet = Character.call_battlenet(self.realm.region, self.realm.name, self.name)    
    self.update_attributes(battlenet) if battlenet[:status].nil?
  end
  
  
  def self.find_or_retrieve(region, realm, name)
    
    realm = Realm.find_by_region_and_name(region, realm)
    character = realm.characters.find_by_name(name.capitalize)
    
    if character.nil?
      bn = call_battlenet(region, realm.slug, name)
      character = realm.characters.build(bn) if bn[:status].nil?
      return character if character.save
    end
  end
  
  
  def self.call_battlenet(region, realm, name)
    bn = BattleNet::getCharacter(:region => region, :realm => realm, :name => name)
    bn.delete(:realm)
    return bn
  end
end
